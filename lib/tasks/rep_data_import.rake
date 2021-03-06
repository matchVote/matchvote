require "#{Rails.root}/lib/matchvote_data_compiler"
require "#{Rails.root}/lib/legislators_data_compiler"
require "#{Rails.root}/lib/image_url_parser"
require "#{Rails.root}/lib/biography_sanitizer"

namespace :reps do
  task import_default_data: :environment do
    Rake::Task["reps:load_profile_data"].invoke
    Rake::Task["reps:load_image_urls"].invoke
    Rake::Task["reps:load_bios"].invoke
    # Rake::Task["reps:set_name_recognition"].invoke
  end

  task load_profile_data: :environment do
    Rake::Task["reps:load_legislators_files"].invoke
    Rake::Task["reps:load_matchvote_files"].invoke
  end

  task load_legislators_files: :environment do
    legislators = YAML.load_file("db/data/legislators-current.yaml")
    social_ids = YAML.load_file("db/data/legislators-social-media.yaml")

    legislators.each do |rep_data|
      bioguide_id = rep_data["id"]["bioguide"]
      rep_social_ids = social_ids.select { |id| id["id"]["bioguide"] == bioguide_id }

      compiler = LegislatorsDataCompiler.new(rep_data, rep_social_ids)
      rep = Representative.find_or_create_by(slug: compiler.generate_slug)
      rep.update!(compiler.compile_attributes)
    end
  end

  task load_matchvote_files: :environment do
    matchvote_files = ["2015_Governors.yml", "2017_Governors.yml", "2015_HighProfile.yml", "2017_Mayors.yml"]

    matchvote_files.each do |file|
      reps = YAML.load_file("#{Rails.root}/db/data/#{file}")
      reps.each do |rep|
        compiler = MatchvoteDataCompiler.new(rep)
        rep = Representative.find_or_create_by(slug: compiler.generate_slug)
        rep.update!(compiler.compile_attributes)
      end
    end
  end

  task load_image_urls: :environment do
    file1 = File.readlines("#{Rails.root}/db/data/2015_SenatorProfileImageURLs.txt")
    file2 = File.readlines("#{Rails.root}/db/data/2017_CongressProfileImageURLs.txt")
    file3 = File.readlines("#{Rails.root}/db/data/2017_GovernorProfileImageURLs.txt")
    file4 = File.readlines("#{Rails.root}/db/data/2017_MayorProfileImageURLs.txt")
    urls = file1.concat(file2.concat(file3.concat(file4)))
    parser = ImageURLParser.new(urls.map(&:chomp))

    Representative.find_each do |rep|
      if rep.profile_image_url.nil?
        rep.update!(profile_image_url: parser.find_url(rep))
      end
    end

    Rake::Task["reps:manually_load_image_urls"].invoke
  end

  task load_bios: :environment do
    Representative.find_each do |rep|
      bio = if (wiki_id = rep.contact.external_ids["wikipedia_id"])
        wiki = WikipediaService.new(rep.contact.external_ids["wikipedia_id"])
        BiographySanitizer.new(wiki.first_paragraph).sanitize
      else
        "To be added."
      end

      rep.update!(biography: bio)
    end
  end

  task manually_load_image_urls: :environment do
    base_uri = "https://data.matchvote.com/images/"
    data = [
      { slug: "george-bynum", url: "2017/mayors/GT_Bynum.jpeg" },
      { slug: "tomas-regalado", url: "2017/mayors/Tomas_Regalado.jpeg" },
      { slug: "john-bel-edwards", url: "2015/governors/John_Bel_Edwards.jpeg" },
      { slug: "mario-diaz-balart", url: "2015/congress/Mario_Diaz_Balart.jpeg" },
      { slug: "ileana-ros-lehtinen", url: "2015/congress/Ileana_Ros_Lehtinen.jpeg" },
      { slug: "lucille-roybal-allard", url: "2015/congress/Lucille_Roybal_Allard.jpeg" },
      { slug: "beto-o?rourke", url: "2015/congress/Beto_ORourke.jpeg" },
      { slug: "gk-butterfield", url: "2015/congress/G_K_Butterfield.jpeg" },
      { slug: "earl-ray-tomblin", url: "2015/governors/Earl_Ray_Tomblin.jpeg" }
    ]

    data.each do |rep_data|
      rep = Representative.find_by(slug: rep_data[:slug])
      rep.update!(profile_image_url: "#{base_uri}#{rep_data[:url]}")
    end
  end

  task set_name_recognition: :environment do
    Representative.find_each do |rep|
      if (slug = rep.contact.external_ids["facebook_username"])
        results = Virility::Facebook.new("http://facebook.com/#{slug}").poll
        unless rep.name_recognition.to_i > results["like_count"].to_i
          rep.update!(name_recognition: results["like_count"])
        end
      end
    end
  end
end
