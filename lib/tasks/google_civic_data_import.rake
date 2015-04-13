require "#{Rails.root}/lib/civic_data_service"

namespace :reps do
  task import_google_civic_data: :environment do
    if Dir["#{Rails.root}/db/data/civic_data/*"].empty?
      CivicDataService.new.dump_data_for_all_states
    end

    Dir["#{Rails.root}/db/data/civic_data/*_civic_data.json"].each do |file|
      json = JSON.parse(File.read(file))
      # compiler = CivicDataCompiler.new(json)
      # rep = Representative.find_or_create_by(slug: compiler.generate_slug)
    end
  end
end
