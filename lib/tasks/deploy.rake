namespace :deploy do
  task heroku: :environment do
    sh "git push heroku master"
    sh "heroku run rake db:migrate --app matchvote"
  end
end

