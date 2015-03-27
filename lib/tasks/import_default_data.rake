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
  end

  task load_profile_data: :environment do
    legislators = YAML.load_file("db/data/legislators-current.yaml")
    social_ids = YAML.load_file("db/data/legislators-social-media.yaml")

    legislators.each do |rep_data|
      bioguide_id = rep_data["id"]["bioguide"]
      rep_social_ids = social_ids.select { |id| id["id"]["bioguide"] == bioguide_id }

      compiler = CongressLegislatorsDataCompiler.new(rep_data, rep_social_ids)
      rep = Representative.find_or_create_by(
        bioguide_id: bioguide_id,
        first_name:  compiler.first_name_sanitized,
        last_name:   compiler.last_name_sanitized)
      rep.update_attributes(compiler.compile_attributes)
    end
  end

  task load_image_urls: :environment do
    urls = File.readlines("#{Rails.root}/db/data/SenatorProfileImageURLs.txt")
    parser = ImageURLParser.new(urls.map(&:chomp))
    Representative.all.each do |rep|
      rep.update_attribute(:profile_image_url, parser.find_url(rep))
    end

    # hardcoded for now; these reps don't have source data that matches 
    # names in url file
    rep = Representative.find_by(first_name: "jefferson", last_name: "sessions")
    rep.update_attribute(:profile_image_url, 
      "http://data.matchvote.com/images/2015/senators/Jeffery_Sessions.png")

    rep = Representative.find_by(first_name: "kelly", last_name: "ayotte")
    rep.update_attribute(:profile_image_url, 
      "http://data.matchvote.com/images/2015/senators/Kelley_Ayotte.png")
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

