# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # registrations_controller.rb

  def select  ##登録方法の選択ページ
    redirect_to root_path, alert: "ログインしています。" if user_signed_in?
    @auth_text = "で登録する"
    session.delete(:"devise.sns_auth") if session["devise.sns_auth"]
  end

  def new
    ## ↓sessionにsns認証のデータがある場合
    @user = User.new(session["devise.sns_auth"]["user"]) if session["devise.sns_auth"]
    ## ↓sessionにsns認証のデータがない場合
    super if !session["devise.sns_auth"]
  end

  def create
    redirect_to new_user_registration_path, alert: "reCAPTCHAを承認してください" and return unless verify_recaptcha
    # super if !session["devise.sns_auth"]
    if session["devise.sns_auth"]
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
      sns = SnsCredential.new(session["devise.sns_auth"]["sns"])
      super
      if user_signed_in?
        sns.user_id = current_user.id
        sns.save
      end
    end

    #storing params to Sessions so as to save User record
    session[:email] = params[:user][:email]
    session[:nickname] = params[:user][:nickname]
    session[:last_name] = params[:user][:last_name]
    session[:first_name] = params[:user][:first_name]
    session[:last_name_reading] = params[:user][:last_name_reading]
    session[:first_name_reading] = params[:user][:first_name_reading]
    session[:birthday] = params[:user][:birthday]

    if params[:user][:password].present?
      session[:password] = params[:user][:password]
      session[:password_confirmation] = params[:user][:password_confirmation]
    else
      session[:password] = "Devise.friendly_token.first(6)"
      session[:password_confirmation] = "Devise.friendly_token.first(6)"
    end
     
    redirect_to confirm_phone_path
  end

  def confirm_phone  ##電話番号確認
  end

  def new_address

    session[:phone_number] = params[:session][:phone_number]
    session[:postal_code] = params[:session][:postal_code]
    session[:prefecture] = params[:session][:prefecture]
    session[:city] = params[:session][:city]
    session[:house_number] = params[:session][:house_number]
    session[:building_name] = params[:session][:building_name]
  end

  # def after_sign_out_path_for(resource)
  #   '/users/confirm_phone' 
  # end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
