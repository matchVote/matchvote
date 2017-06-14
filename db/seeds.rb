# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).

print "Seeding database..."
Rake::Task["import:all_default_data"].invoke
Rake::Task["articles:load"].invoke
puts "Done!"
