class BuyController < ApplicationController

  def show
    @items = Item.find(params[:id])

    @addresses = Address.find(current_user.id)
    
    @credits = Credit.find(current_user.id)
  end

end
