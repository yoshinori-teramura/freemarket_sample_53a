class CreditController < ApplicationController
  
  require "payjp"

  def new
    credit = Credit.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      credit: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @credit = Credit.new(user_id: currendt_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete
    credit = Credit.where(user_id: current_user.id).first
    if credit.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(credit.customer_id)
      customer.delete
      credit.delete
    end
      redirect_to action: "new"
  end

  def show
    credit = Credit.where(user_id: currendt_user.id).first
    if credit.blank?
      redirect_to action:"new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(credit.customer_id)
      @default_card_information = customer.cards.retrieve(credit.card_id)
    end
  end
end
