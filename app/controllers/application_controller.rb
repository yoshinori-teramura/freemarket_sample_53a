class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  
  # before_action :configure_permited_parameters, if: :devise_controller?

  # def configure_permited_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_kana_name, :first_kana_name, :birthday, :tel])
  # end
  
  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
