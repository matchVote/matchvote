require_relative "#{Rails.root}/lib/mail_chimp_subscriber"

namespace :email do
  task subscribe_users: :environment do
    users = User.all
    response = MailChimpSubscriber.new.batch(users)
    puts "#{users.size} MailChimp subscriptions added; Response Code: #{response.code}"
  end
end
