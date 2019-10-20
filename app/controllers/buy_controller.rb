class BuyController < ApplicationController

  def show
    @items = Item.find(params[:id])
  end

end
