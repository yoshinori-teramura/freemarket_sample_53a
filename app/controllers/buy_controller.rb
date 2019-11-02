class BuyController < ApplicationController

  def show
    @item = Item.find(params[:id])

    @address = Address.find(current_user.id)
    
    @credit = Credit.find(current_user.id)
  end

  def purchase
    @item = Item.find(params[:id])

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
