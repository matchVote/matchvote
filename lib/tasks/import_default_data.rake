require "#{Rails.root}/lib/congress_legislators_data_compiler"
require "#{Rails.root}/lib/image_url_parser"
require "#{Rails.root}/lib/biography_sanitizer"

namespace :import do
  task all_default_data: :environment do
    Rake::Task["reps:import_default_data"].invoke
    Rake::Task["app:import_default_data"].invoke
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

