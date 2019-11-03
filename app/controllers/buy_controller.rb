class BuyController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @item = Item.find(params[:id])

    @address = Address.find(current_user.id)
    
    #@credit = Credit.find(current_user.id)

    card = Credit.where(user_id: current_user.id).first
    if card.blank?
      redirect_to controller: "credit", action: "edit"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def purchase
    
    @item = Item.find(params[:id])
    card = Credit.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  #redirect_to action: 'done' #完了画面に移動
    # 2(:trading、取引中)へ状態を変更
    @item[:trade_status] = Item.trade_statuses[:trading]

    # 例外の場合、"rescue => e"へ飛ぶ
    @item.save!

    # buy#purchaseへ飛ぶ
    # render action: :purchase

    rescue => e
      puts e
      redirect_to :root, notice: '購入を確定できませんでした'
  end

end
