class SignupController < ApplicationController
  # before_action :authenticate_user!
  #次の画面に遷移する前に情報を保存する
  before_action :save_registration, only: :sms_confirmation 
  before_action :save_sms_confirmation, only: :address
  before_action :save_address, only: :credit
  before_action :save_credit, only: :create

  def registration_type
    reset_session
    #sessionで保持している値のリセット
  end

  def registration

    password = Devise.friendly_token.first(6)
    #ランダムでpasswordの作成
    if session[:sns_credentials_attributes].present?
      @user = User.new(nickname: session[:sns_nickname],email: session[:sns_email], password: password)
      #googleやfacebookからのログインでprovider情報を取得して来ていれば、nickname／email/password情報の保持
      @user.sns_credentials.build
    #has_manyの関係性のbuild:インスタンス名.アソシエーション.build
    else
      @user = User.new
      #メールからの登録であれば、新規インスタンスの作成
    end
  end

  def sms_confirmation
    @user = User.new
  end

  def address
    @user = User.new
    @user.build_address
    #has_oneの関係性のbuild:インスタンス名.build_アソシエーション名
  end

  def credit
    @user = User.new
    @user.build_credit
    #has_oneの関係性のbuild:インスタンス名.build_アソシエーション名
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
    #以下、アソシエーションモデルをまとめて保存
    @user.build_address(session[:address_attributes])
    @user.build_credit(session[:credit_attributes])
    if session[:sns_credentials_attributes].present?
      @user.sns_credentials.build(session[:sns_credentials_attributes])
      #googleやfacebookからのログインでprovider情報を取得して来ていれば、sns_credentialsテーブルへ保存
    end
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
      :password_confirmaiton,
      :family_name, 
      :first_name, 
      :family_kana_name, 
      :first_kana_name, 
      :birthday,
      :tel,
      address_attributes:[
        :id,
        :user_id,
        :delivery_family_name,
        :delivery_first_name,
        :delivery_family_kana_name,
        :delivery_first_kana_name,
        :postal_code,
        :prefecture_id,
        :city,
        :block,
        :building_name,
        :delivery_tel],
      credit_attributes:[
        :id,
        :user_id,
        :number,
        :expiration_date,
        :security_code],
      sns_credentials_attributes:[
        :provider,
        :uid])
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
    session[:birthday] = Date.new(user_params["birthday(1i)"].to_i, user_params["birthday(2i)"].to_i, user_params["birthday(3i)"].to_i)
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
      tel: 12345678901 
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

  def save_address
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
    session[:address_attributes]= user_params[:address_attributes]    # @user.build_address(user_params[:address_attributes])
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
    session[:credit_attributes] = user_params[:credit_attributes]    # @user.build_credit(user_params[:credit_attributes])
  end
end
