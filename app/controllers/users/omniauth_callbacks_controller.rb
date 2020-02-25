# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_for(:facebook)
  end

  def google
    callback_for(:google)
  end

  def callback_for(provider)
    ## find_oauthメソッドで既に登録されているかなどを調べる。返り値としてハッシュ形式でuserとsns_credentialをもらう。
    session["devise.sns_auth"] = User.find_oauth(request.env["omniauth.auth"])
    if session["devise.sns_auth"][:user].persisted? ## 登録済みだったらログイン
      sign_in_and_redirect session["devise.sns_auth"][:user], event: :authentication
    else ## まだ登録されていないなら新規登録画面へ飛ばす。
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path and return
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
