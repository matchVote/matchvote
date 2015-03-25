require "#{Rails.root}/lib/congress_legislators_data_compiler"

namespace :import do
  task default_data: :environment do
    Rake::Task["reps:import_default_data"].invoke
    Rake::Task["app:import_default_data"].invoke
  end
end

namespace :reps do
  task import_default_data: :environment do
    Rake::Task["reps:bioguide_ids"].invoke
    Rake::Task["reps:rep_profile_data"].invoke
    Rake::Task["reps:rep_image_urls"].invoke
  end

  task bioguide_ids: :environment do
    legislators = YAML.load_file("db/data/legislators-current.yaml")

    bioguide_hash = legislators.reduce({}) do |hash, rep_data|
      hash.merge!({ 
        "#{rep_data["id"]["bioguide"]}" => { 
          "first"    => "#{rep_data["name"]["first"].downcase}", 
          "last"     => "#{rep_data["name"]["last"].downcase}" }})
          # "nickname" => "#{rep_data["name"]["nickname"].downcase}" } })
    end

    File.open("db/data/rep_bioguide_ids.yml", "w") do |f|
      f.write bioguide_hash.to_yaml
    end
  end

  task rep_profile_data: :environment do
    legislators = YAML.load_file("db/data/legislators-current.yaml")
    social_ids = YAML.load_file("db/data/legislators-social-media.yaml")

    legislators.each do |rep_data|
      bioguide_id = rep_data["id"]["bioguide"]
      rep_social_ids = social_ids.select { |id| id["id"]["bioguide"] == bioguide_id }

      compiler = CongressLegislatorsDataCompiler.new(rep_data, rep_social_ids)
      rep = Representative.find_or_create_by(
        bioguide_id: bioguide_id,
        first_name:  rep_data["name"]["first"].downcase,
        last_name:   rep_data["name"]["last"].downcase)
      rep.update_attributes(compiler.compile_attributes)
    end
  end

  task rep_image_urls: :environment do
    urls = File.readlines("db/data/SenatorProfileImageURLs.txt").map(&:chomp)
    bioguides = YAML.load_file("db/data/rep_bioguide_ids.yml")

    bioguides.each do |bioguide_id, name|
      url = urls.find do |url|
        first, last = url.split("/").last.split(".").first.split("_")
        name["first"].match(Regexp.new(first.downcase)) && 
          name["last"].match(Regexp.new(last.downcase))
      end
      rep = Representative.find_by(bioguide_id: bioguide_id)
      rep.update_attribute(:profile_image_url, url)
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

