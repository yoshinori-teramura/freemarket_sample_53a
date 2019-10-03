class SignupController < ApplicationController

  before_action :save_registration, only: :sms_confirmation 
  before_action :save_sms_confirmation, only: :adress
  before_action :save_adress, only: :create

  def registration_type
  end

  def registration
    @user = User.new 
  end

  def sms_confirmation
    @user = User.new
  end

  def adress
    @user = User.new
    @user.build_adress
  end

  def credit
    @user = User.new
    @user.build_credit
    # binding.pry
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
    @user.build_adress(user_params[:adress_attributes])
    @user.build_credit(user_params[:credit_attributes])
    # binding.pry
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
    params.require(:user).permit(:nickname,
      :email,
      :password,
      :password_confirmation, 
      :family_name, :first_name, 
      :family_kana_name, 
      :first_kana_name, 
      :birthday,
      :tel,
      adress_attributes:[
        :id,
        :user_id,
        :delivery_family_name,
        :delivery_first_name,
        :delivery_family_kana_name,
        :delivery_first_kana_name,
        :postal_code,
        :prefecture,
        :city,
        :block,
        :building_name,
        :delivery_tel],
      credit_attributes:[
        :id,
        :user_id,
        :number,
        :neme,
        :expiration_date])
  end

  def save_registration
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
      nickname: session[:nickname], 
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
     session[:tel] = user_params[:tel]
     @user = User.new(
       nickname: session[:nickname],
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

  def save_adress
    @user = User.new(
      nickname: session[:nickname],
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
    # binding.pry
  end

  def save_credit
    @user = User.new(
      nickname: session[:nickname],
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
    @user.build_adress(user_params[:adress_attributes])
    # binding.pry
  end

  def complete
    @user = User.new(
      nickname: session[:nickname],
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
    @user.build_adress(user_params[:adress_attributes])
    @user.build_credit(user_params[:credit_attributes])
  end

end
