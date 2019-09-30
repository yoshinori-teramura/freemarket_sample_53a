class SignupController < ApplicationController

  before_action :save_registration, only: :sms_confirmation 
  before_action :save_sms_confirmation, only: :create

  def registration_type
  end

  def registration
    @user = User.new 
  end

  def sms_confirmation
    session[:tel] = user_params[:tel]
    
  end

  def create
    @user = User.new(
      nickname: session[:nickname], 
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name],
      first_name: session[:first_name],
      family_kana_name: session[:family_kana_name],
      first_kana_name: session[:first_kana_name],
      birthday: session[:birthday],
      tel: session[:tel]
    )
    if @user.save
      session[:id] = @user.id
      redirect_to complete_signup_index_path
    else
      render '/signup/registration'
    end
  end

  def complete
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :family_name, :first_name, :family_kana_name, :first_kana_name, :birthday,:tel)
  end

  def save_registration
    # registrationで入力した値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:family_name] = user_params[:family_name]
    session[:first_name] = user_params[:first_name]
    session[:family_kana_name] = user_params[:family_kana_name]
    session[:first_kana_name] = user_params[:first_kana_name]
    session[:birthday] = user_params[:birthday]
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name],
      first_name: session[:first_name],
      family_kana_name: session[:first_kana_name],
      first_kana_name: session[:first_kana_name],
      birthday: session[:birthday], 
      tel: 12345678901, 
    )
  end

  def save_sms_confirmation
     # registrationで入力した値をsessionに保存
     session[:tel] = user_params[:tel]
     @user = User.new(
       nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
       email: session[:email],
       password: session[:password],
       password_confirmation: session[:password_confirmation],
       family_name: session[:family_name],
       first_name: session[:first_name],
       family_kana_name: session[:first_kana_name],
       first_kana_name: session[:first_kana_name],
       birthday: session[:birthday], 
       tel: session[:tel] 
     )
  end

end
