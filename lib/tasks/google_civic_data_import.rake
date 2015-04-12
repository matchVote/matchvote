require "#{Rails.root}/lib/civic_data_service"

namespace :reps do
  task import_google_civic_data: :environment do
    if Dir["#{Rails.root}/db/data/civic_data/*"].empty?
      CivicDataService.new.dump_data_for_all_states
    end

    # load json into DB
  end
end
