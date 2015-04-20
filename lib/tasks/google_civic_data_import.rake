require "#{Rails.root}/lib/civic_data/service"
require "#{Rails.root}/lib/civic_data/importer"

namespace :reps do
  task import_google_civic_data: :environment do
    if Dir["#{Rails.root}/db/data/civic_data/*"].empty?
      service = CivicData::Service.new
      service.dump_data_for_all_states
      service.fetch_officials_by_division_for(state: "OH")
      service.fetch_officials_by_division_for(state: "PA")
    end

    Dir["#{Rails.root}/db/data/civic_data/**/*_civic_data*.json"].each do |file|
      p file
      json = JSON.parse(File.read(file))

      json["offices"].each do |office|
        CivicData::Importer.new(office, json["officials"]).import
      end
    end
  end
end

