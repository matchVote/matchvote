require "#{Rails.root}/lib/governor_data_compiler"

namespace :reps do
  task import_default_data: :environment do
    Rake::Task["reps:load_profile_data"].invoke
    Rake::Task["reps:load_image_urls"].invoke
    Rake::Task["reps:load_bios"].invoke
    Rake::Task["reps:set_name_recognition"].invoke
  end

  task load_profile_data: :environment do
    Rake::Task["reps:load_legislators_files"].invoke
    Rake::Task["reps:load_matchvote_files"].invoke
    Rake::Task["reps:import_google_civic_data"].invoke
  end

  task load_legislators_files: :environment do
    legislators = YAML.load_file("db/data/legislators-current.yaml")
    social_ids = YAML.load_file("db/data/legislators-social-media.yaml")

    legislators.each do |rep_data|
      bioguide_id = rep_data["id"]["bioguide"]
      rep_social_ids = social_ids.select { |id| id["id"]["bioguide"] == bioguide_id }

      compiler = CongressLegislatorsDataCompiler.new(rep_data, rep_social_ids)
      rep = Representative.find_or_create_by(slug: compiler.generate_slug)
      rep.update_attributes(compiler.compile_attributes)
    end
  end

  task load_matchvote_files: :environment do
    matchvote_files = ["2015_Governors.yml", "2015_HighProfile.yml"]

    matchvote_files.each do |file|
      reps = YAML.load_file("#{Rails.root}/db/data/#{file}")
      reps.each do |rep|
        compiler = MatchvoteDataCompiler.new(rep)
        rep = Representative.find_or_create_by(slug: compiler.generate_slug)
        rep.update_attributes(compiler.compile_attributes)
      end
    end
  end

  task load_image_urls: :environment do
    file1 = File.readlines("#{Rails.root}/db/data/2015_SenatorProfileImageURLs.txt")
    file2 = File.readlines("#{Rails.root}/db/data/2015_CongressProfileImageURLs.txt")
    file3 = File.readlines("#{Rails.root}/db/data/2015_GovernorProfileImageURLs.txt")
    urls = file1.concat(file2.concat(file3))
    parser = ImageURLParser.new(urls.map(&:chomp))

    Representative.find_each do |rep|
      rep.update_attribute(:profile_image_url, parser.find_url(rep))
    end

    Rake::Task["reps:manully_load_image_urls"].invoke
  end

  task load_bios: :environment do
    Representative.find_each do |rep|
      bio = if (wiki_id = rep.external_credentials["wikipedia_id"])
        wiki = WikipediaService.new(rep.external_credentials["wikipedia_id"])
        BiographySanitizer.new(wiki.first_paragraph).sanitize
      else
        "To be added."
      end

      rep.update_attribute(:biography, bio)
    end
  end

  task manully_load_image_urls: :environment do
    base_uri = "http://data.matchvote.com/images/2015/"
    data = [
      { slug: "jeff-sessions", url: "senators/Jeffery_Sessions.png" },
      { slug: "kelly-ayotte", url: "senators/Kelley_Ayotte.png" },
      { slug: "yvette-clarke", url: "congress/Yvette_Clark.png" },
      { slug: "mario-diaz-balart", url: "congress/Mario_Diaz_Balart.png" },
      { slug: "ileana-ros-lehtinen", url: "congress/Ileana_Ros_Lehtinen.png" },
      { slug: "lucille-roybal-allard", url: "congress/Lucille_Roybal_Allard.png" },
      { slug: "jim-sensenbrenner", url: "congress/James_Sensenbrenner.png" },
      { slug: "beto-o-rourke", url: "congress/Beto_ORourke.png" },
      { slug: "gk-butterfield", url: "congress/G_K_Butterfield.png" },
      { slug: "chaka-fattah", url: "congress/Chaka_Farrah.png" }
    ]

    data.each do |rep_data|
      rep = Representative.find_by(slug: rep_data[:slug])
      rep.update_attribute(:profile_image_url, "#{base_uri}#{rep_data[:url]}")
    end
  end

  task set_name_recognition: :environment do
    Representative.find_each do |rep|
      if (slug = rep.external_credentials["facebook_username"])
        results = Virility::Facebook.new("http://facebook.com/#{slug}").poll
        rep.update_attribute(:name_recognition, results["like_count"])
      else
        rep.update_attribute(:name_recognition, 0)
      end
    end
  end
end

