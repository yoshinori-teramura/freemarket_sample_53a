class BuyController < ApplicationController

  def show
    @items = Item.find(params[:id])

    @address = Address.find(current_user.id)
    
  end

end
