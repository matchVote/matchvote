namespace :import do
  task all_default_data: :environment do
    Rake::Task["reps:import_default_data"].invoke
    Rake::Task["app:import_stance_data"].invoke
  end
end

