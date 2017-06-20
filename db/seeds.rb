# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).

if Rails.env.development?
  print "Populating database for development..."

  # Quick rep load
  pg_dump = Rails.root.join("db/data/rep_seeds_6-20-17.dump")
  db = Rails.configuration.database_configuration['development']
  conn = "#{db['database']} -h #{db['host']} -p #{db['port']} -U #{db['username']}"
  `psql #{conn} < #{pg_dump}`

  Rake::Task["app:import_stance_data"].invoke
  Rake::Task["articles:load"].invoke
  puts "Done!"
end
