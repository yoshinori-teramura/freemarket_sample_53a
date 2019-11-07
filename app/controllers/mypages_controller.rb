class MypagesController < ApplicationController
  before_action :authenticate_user!

  def index
    set_buyer_purchase
    set_buyer_purchased
  end

  def profile
    @user=User.find(current_user.id)
  end

  def deliver_address
    @address=Address.find_by(user_id: current_user.id)
  end

  def email_password
    @user=User.find(current_user.id)
  end

  def identification
    @address=Address.find_by(user_id: current_user.id)
  end

  def sms_confirmation
    @user=User.find(current_user.id)
  end

  def credit
    @credit=Credit.find_by(user_id: current_user.id)
    if @credit.present?
      card = Credit.where(user_id: current_user.id).first
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def purchase
    set_buyer_purchase
  end

  def purchased
    set_buyer_purchased
  end

  def update_user
    @user=User.find(current_user.id)
    @user.update(user_params)
    if @user.update(id:current_user.id)
      redirect_to mypages_path, notice: '更新しました。'
    else
      redirect_to mypages_path, notice: '更新失敗！！！'
    end
  end

  def update_address
    @address=Address.find_by(user_id: current_user.id)
    @address.update(address_params)
    if @address.update(user_id: current_user.id)
      redirect_to mypages_path, notice: '更新しました。'
    else
      redirect_to mypages_path, notice:'更新失敗！！！！'
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :id,
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

  def set_buyer_purchase
    @buyer_purchase = Buyer.joins(:item)
                           .where(items: {trade_status: :trading})
                           .where(user_id: current_user.id)
                           .order(created_at: 'DESC')
  end

  def set_buyer_purchased
    @buyer_purchased = Buyer.joins(:item)
                            .where(items: {trade_status: :sold})
                            .where(user_id: current_user.id)
                            .order(created_at: 'DESC')
  end

end
