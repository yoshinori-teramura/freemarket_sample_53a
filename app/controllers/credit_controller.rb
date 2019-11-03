class CreditController < ApplicationController

  #before_action :get_user_params, only: [:edit, :confirmation, :show]
  before_action :get_payjp_info, only: [:new_create, :create, :delete, :show]

  def edit
  end

  def create
    if params['payjp-token'].blank?
      redirect_to action: "edit", id: current_user.id
    else
      begin
        customer = Payjp::Customer.create(
          email: current_user.email,
          card: params['payjp-token'],
          metadata: {user_id: current_user.id}
        )
        @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        if @credit.save
          redirect_to action: "show"
        else
          redirect_to action: "edit", id: current_user.id
        end
      rescue Payjp::CardError => e
        body = e.json_body
        err  = body[:error]
        puts "Message is: #{err[:message]}"
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::InvalidRequestError => e
        # Invalid parameters were supplied to Payjp's API
        puts "InvalidRequestError: #{e}"
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::AuthenticationError => e
        # Authentication with Payjp's API failed
        puts "AuthenticationError: #{e}"
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::APIConnectionError => e
        # Network関連でエラーが発生した場合の例外
        puts "APIConnectionError: #{e}"
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::APIError => e
        # 上記以外の特殊なケースの例外
        puts "APIError: #{e}"
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::PayjpError => e
        # PayjpErrorは上記5種類の独自例外クラスの親クラスです
        puts "PayjpError: #{e}"
        redirect_to action: "edit", id: current_user.id
      rescue => e
        # Something else happened, completely unrelated to Payjp
        puts "Unknown Error: #{e}"
        redirect_to action: "edit", id: current_user.id
      end
    end
  end

  def delete
    card = Credit.where(user_id: current_user.id).first
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "confirmation", id: current_user.id
  end

  def show
    card = Credit.where(user_id: current_user.id).first
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    else
      redirect_to action: "confirmation", id: current_user.id
    end
  end

  def confirmation
    card = current_user.credits
    redirect_to action: "show" if card.exists?
  end

  private

  def get_payjp_info
    #if Rails.env == 'development'
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    #else
      #Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    #end
  end
end