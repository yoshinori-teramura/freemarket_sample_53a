class CreditController < ApplicationController

  #before_action :get_user_params, only: [:edit, :confirmation, :show]
  before_action :get_payjp_info, only: [:new_create, :create, :delete, :show]

  def edit
  end

  def create
    # TODO:確認用ログあとで消す
    last_logger_level = Rails.logger.level
    Rails.logger.level = 0

    logger.debug {"api_key: #{Payjp.api_key}"}

    if params['payjp-token'].blank?
      logger.debug {"CreditController#create: payjp-token does not exist."}
      redirect_to action: "edit", id: current_user.id
    else
      begin
        logger.debug {"CreditController#create: Payjp::Customer.create START"}
        customer = Payjp::Customer.create(
          email: current_user.email,
          card: params['payjp-token'],
          metadata: {user_id: current_user.id}
        )
        logger.debug {"#{customer}"}
        logger.debug {"CreditController#create: Payjp::Customer.create END"}

        logger.debug {"CreditController#create: Credit.save START"}
        @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        @credit.save!
        logger.debug {"CreditController#create: Credit.save END"}

        redirect_to action: "show"
      rescue Payjp::CardError => e
        body = e.json_body
        err  = body[:error]
        logger.error {"Message is: #{err[:message]}"}
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::InvalidRequestError => e
        # Invalid parameters were supplied to Payjp's API
        logger.error {"InvalidRequestError: #{e}"}
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::AuthenticationError => e
        # Authentication with Payjp's API failed
        logger.error {"AuthenticationError: #{e}"}
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::APIConnectionError => e
        # Network関連でエラーが発生した場合の例外
        logger.error {"APIConnectionError: #{e}"}
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::APIError => e
        # 上記以外の特殊なケースの例外
        logger.error {"APIError: #{e}"}
        redirect_to action: "edit", id: current_user.id
      rescue Payjp::PayjpError => e
        # PayjpErrorは上記5種類の独自例外クラスの親クラスです
        logger.error {"PayjpError: #{e}"}
        redirect_to action: "edit", id: current_user.id
      rescue => e
        # Something else happened, completely unrelated to Payjp
        logger.error {"Unknown Error: #{e}"}
        redirect_to action: "edit", id: current_user.id
      ensure
        # TODO:確認用ログあとで消す
        Rails.logger.level = last_logger_level
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