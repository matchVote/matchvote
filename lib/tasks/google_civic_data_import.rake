require "#{Rails.root}/lib/civic_data/service"
require "#{Rails.root}/lib/civic_data/compiler"

namespace :reps do
  task import_google_civic_data: :environment do
    if Dir["#{Rails.root}/db/data/civic_data/*"].empty?
      CivicData::Service.new.dump_data_for_all_states
    end

    # Dir["#{Rails.root}/db/data/civic_data/*_civic_data.json"].each do |file|
    Dir["#{Rails.root}/db/data/civic_data/AK*"].each do |file|
      json = JSON.parse(File.read(file))

      json["offices"].each do |office|
        CivicData::Importer.new(office, json["officials"]).import
      end
    end
  end
end

