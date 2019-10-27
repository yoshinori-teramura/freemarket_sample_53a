class MypagesController < ApplicationController
  before_action :authenticate_user!
  
  def index  
  end

  
  def profile
    @user=User.find(params[:id])
  end

  
  def deliver_address
    @address=Address.find(params[:id])
  end

  def email_password
    @user=User.find(params[:id])
  end

  def identification
    @address=Address.find(params[:id])
  end

  def sms_confirmation
    @user=User.find(params[:id])    
  end


  def update_user
    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to mypages_path, notice: '更新しました。'
  end

  def update_address
    @address=Address.find(params[:id])
    @address.update(address_params)
    redirect_to mypages_path, notice: '更新しました。'
  end

    private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmaiton,
      :family_name, 
      :first_name, 
      :family_kana_name, 
      :first_kana_name, 
      :birthday,
      :tel,
      :profile)
    end
  def address_params
    params.require(:address).permit(
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
      :delivery_tel)
    end
end
