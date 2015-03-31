require "#{Rails.root}/lib/congress_legislators_data_compiler"
require "#{Rails.root}/lib/image_url_parser"

namespace :import do
  task default_data: :environment do
    Rake::Task["reps:import_default_data"].invoke
    Rake::Task["app:import_default_data"].invoke
  end
end

namespace :reps do
  task import_default_data: :environment do
    Rake::Task["reps:load_profile_data"].invoke
    Rake::Task["reps:load_image_urls"].invoke
    Rake::Task["reps:load_bios"].invoke
  end

  task load_profile_data: :environment do
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

  task load_image_urls: :environment do
    urls = File.readlines("#{Rails.root}/db/data/2015_SenatorProfileImageURLs.txt").
      concat(File.readlines("#{Rails.root}/db/data/2015_CongressProfileImageURLs.txt"))
    parser = ImageURLParser.new(urls.map(&:chomp))

    Representative.all.each do |rep|
      rep.update_attribute(:profile_image_url, parser.find_url(rep))
    end

    #BH hardcoded for now; these reps don't have source data that matches
    # names in url file
    Rake::Task["reps:manully_load_image_urls"].invoke
  end

  task load_bios: :environment do
    Representative.all.each do |rep|
      wiki = WikipediaService.new(rep.external_credentials["wikipedia_id"])
      rep.update_attribute(:biography, wiki.first_paragraph)
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
end

namespace :app do
  task import_default_data: :environment do
    Rake::Task["app:import_issues"].invoke
  end

  task import_issues: :environment do
    File.readlines("db/data/issues.csv").each do |issue|
      Issue.create(name: issue.chomp)
    end
  end
end
