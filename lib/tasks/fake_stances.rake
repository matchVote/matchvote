namespace :fake_stances do
  desc "Creates stances for all reps to test matching performance"
  task for_reps: :environment do
    Stance.destroy_all
    Representative.all.each do |rep|
      Statement.limit(30).each do |statement|
        statement.stances.create(opinionable: rep,
          agreeance_value: (-3..3).to_a.sample, 
          importance_value: (0..4).to_a.sample)
      end
    end
  end

  desc "Quickly fill out all stances for a specified user"
  task :for_user, [:username] => :environment do |task, args|
    user = User.find_by(username: args[:username])
    Stance.where(opinionable_id: user).destroy_all
    Statement.all.each do |statement|
      statement.stances.create(opinionable: user,
        agreeance_value: (-3..3).to_a.sample, 
        importance_value: (0..4).to_a.sample)
    end
  end
end
