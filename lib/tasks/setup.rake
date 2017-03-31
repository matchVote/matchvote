namespace :app do
  task setup: :environment do
    if database_exists?
      Rake::Task["db:migrate"].invoke
    else
      Rake::Task["db:setup"].invoke
    end
  end

  def database_exists?
    ActiveRecord::Base.connection
  rescue ActiveRecord::NoDatabaseError
    false
  else
    true
  end
end
