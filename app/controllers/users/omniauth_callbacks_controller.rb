class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])
    puts request.env["omniauth.auth"]

    if @user.persisted?
      sign_in_and_redirect @user
    else
      redirect_to new_user_session_path,
        flash: { error: "Twitter login failed." }
    end
  end
end
