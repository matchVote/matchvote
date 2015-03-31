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
    urls = File.readlines("#{Rails.root}/db/data/2015_SenatorProfileImageURLs.txt")
    parser = ImageURLParser.new(urls.map(&:chomp))
    Representative.all.each do |rep|
      rep.update_attribute(:profile_image_url, parser.find_url(rep))
    end

    #BH hardcoded for now; these reps don't have source data that matches
    # names in url file
    rep = Representative.find_by(first_name: "Jefferson", last_name: "Sessions")
    rep.update_attribute(:profile_image_url,
      "http://data.matchvote.com/images/2015/senators/Jeffery_Sessions.png")

    rep = Representative.find_by(first_name: "Kelly", last_name: "Ayotte")
    rep.update_attribute(:profile_image_url,
      "http://data.matchvote.com/images/2015/senators/Kelley_Ayotte.png")
  end

  task load_bios: :environment do
    Representative.all.each do |rep|
      wiki = WikipediaService.new(rep.external_credentials["wikipedia_id"])
      rep.update_attribute(:biography, wiki.first_paragraph)
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
