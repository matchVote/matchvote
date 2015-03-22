require "#{Rails.root}/lib/congress_legislators_data_compiler"

namespace :import do
  task rep_profile_data: :environment do
    legislators = YAML.load_file("#{Rails.root}/db/data/legislators-current.yaml")
    social_ids = YAML.load_file("#{Rails.root}/db/data/legislators-social-media.yaml")

    legislators.each do |rep_data|
      compiler = CongressLegislatorsDataCompiler.new(rep_data, social_ids)
      rep = Representative.find_or_create_by(
        first_name: rep_data["name"]["first"],
        last_name:  rep_data["name"]["last"])
      rep.update_attributes(compiler.compile_attributes)
    end
  end
end

