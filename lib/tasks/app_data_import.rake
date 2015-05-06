require "#{Rails.root}/lib/hopper_loader"

namespace :app do
  task import_stance_data: :environment do
    HopperLoader.new.load
  end
end

