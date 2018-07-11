module SessionsHelper
  def show_twitter_login?
    ENV['TWITTER_LOGIN'] == 'active'
  end

  def show_facebook_login?
    ENV['FACEBOOK_LOGIN'] == 'active'
  end
end
