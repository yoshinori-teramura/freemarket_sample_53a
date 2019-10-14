# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end


  def callback_for(provider)
    # providerからデータを取得
    @sns_credential = SnsCredential.from_omniauth(request.env["omniauth.auth"])
    binding.pry
    session[:nickname] = request.env["omniauth.auth"].info.name
    session[:email] = request.env["omniauth.auth"].info.email
    session[:password] = Devise.friendly_token[0,20] # deviseで任意のパスワードを生成
    session[:provider] = @sns_credential.provider
    session[:uid] = @sns_credential.uid

    # @omniauth = request.env['omniauth.auth']
    # info = User.find_oauth(@omniauth)
    # # binding.pry
    # @user = info[:user]
    if @sns_credential.persisted?    #@user.persisted? 
      sign_in_and_redirect @user, event: :authentication
      
    else 
      # @sns = info[:sns]
      # session[:provider] = @sns[:provider]
      # session[:uid] = @sns[:uid]
      binding.pry
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
