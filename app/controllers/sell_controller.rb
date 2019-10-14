class SellController < ApplicationController

  def index
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    # FIXME: 仮置き
    redirect_to :root
  end

  private

  def item_params
    params.require(:item).permit(:description, :image)
  end
end
