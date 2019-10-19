# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end


  def callback_for(provider)
    @omniauth = request.env['omniauth.auth']
    # request.envにてHTTPリクエストの値を取得
    info = User.find_oauth(@omniauth)
    @user = info[:user]
    if @user.persisted?
      #persisted?:Active Record object がDB に保存済みかどうかを判定するメソッド
      # @user情報がすでにDBに保存されていればその情報でログイン
      sign_in_and_redirect @user, event: :authentication
    else
      session[:sns_nickname] = info[:user].nickname
      session[:sns_email] = info[:user].email
      #providerから取得したnickname/email情報をsessionに渡す
      session[:sns_credentials_attributes] = info[:sns]
      #providerから取得したuid/provider情報をsessionに渡す
      redirect_to registration_signup_index_path
    end
  end

  def failure
    redirect_to root_path 
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
