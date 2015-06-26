desc "Creates stances for all reps and given user to test matching performance"
desc "Ex: rake fake_stance_matches_for[bob]"
task :fake_stance_matches_for, [:username] => :environment do |task, args|
  Stance.destroy_all
  user = User.find_by(username: args[:username])

  (Representative.all << user).each do |rep|
    Statement.all.each do |statement|
      statement.stances.create(opinionable: rep,
        agreeance_value: (-3..3).to_a.sample, 
        importance_value: (0..4).to_a.sample)
    end
  end
end
