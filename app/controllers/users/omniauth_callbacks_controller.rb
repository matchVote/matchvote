class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    omniauth_login(error_message: "Twitter login failed.")
  end

  def facebook
    omniauth_login(error_message: "Facebook login failed.")
  end

  private

  def omniauth_login(error_message: "Login failed")
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user
    else
      redirect_to new_user_session_path, flash: { error: error_message }
    end
  end
end
