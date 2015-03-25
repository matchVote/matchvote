require "#{Rails.root}/lib/congress_legislators_data_compiler"
require "csv"

namespace :import do
  task all: :environment do
    Rake::Task["import:rep_profile_data"].invoke
    Rake::Task["import:issues"].invoke
  end

  task rep_profile_data: :environment do
    legislators = YAML.load_file("#{Rails.root}/db/data/legislators-current.yaml")
    social_ids = YAML.load_file("#{Rails.root}/db/data/legislators-social-media.yaml")

    legislators.each do |rep_data|
      rep_id = rep_data["id"]["bioguide"]
      rep_social_ids = social_ids.select { |id| id["id"]["bioguide"] == rep_id }

      compiler = CongressLegislatorsDataCompiler.new(rep_id, rep_data, rep_social_ids)
      rep = Representative.find_or_create_by(
        first_name: rep_data["name"]["first"].downcase,
        last_name:  rep_data["name"]["last"].downcase)
      rep.update_attributes(compiler.compile_attributes)
    end
  end

  task issues: :environment do
    CSV.read("#{Rails.root}/db/data/issues.csv").flatten.each do |issue|
      Issue.create(name: issue)
    end
  end
end

