require "#{Rails.root}/lib/civic_data/service"
require "#{Rails.root}/lib/civic_data/importer"

namespace :reps do
  task :import_google_civic_data, [:reset] => :environment do |_, args|
    civic_data_dir = "#{Rails.root}/db/data/civic_data"

    FileUtils.rm_rf(civic_data_dir) if args[:reset]
    Dir.mkdir(civic_data_dir) unless Dir.exist?(civic_data_dir)

    if Dir["#{civic_data_dir}/*.json"].empty?
      Dir.mkdir("#{civic_data_dir}/OH")
      Dir.mkdir("#{civic_data_dir}/PA")
      service = CivicData::Service.new
      service.dump_data_for_all_states
      service.fetch_officials_by_division_for(state: "OH")
      service.fetch_officials_by_division_for(state: "PA")
      File.delete("#{civic_data_dir}/OH_civic_data.json", 
                  "#{civic_data_dir}/PA_civic_data.json")
    end

    Dir["#{Rails.root}/db/data/civic_data/**/*_civic_data*.json"].each do |file|
      p file
      json = JSON.parse(File.read(file))
      offices = NullObject.nullify(json["offices"])

      offices.each do |office|
        CivicData::Importer.new(office, json["officials"]).import
      end
    end
  end
end

