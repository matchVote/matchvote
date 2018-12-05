# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).

if Rails.env.development?
  print "Populating database for development..."
  Rake::Task["app:import_stance_data"].invoke
  Rake::Task["reps:import_default_data"].invoke
  Rake::Task["dev:create_users"].invoke
  Rake::Task["dev:reset_articles"].invoke
  puts "Done!"
end

if Rails.env.production?
  print "Populating database with production seeds..."

  Rake::Task["import:all_default_data"].invoke
end
