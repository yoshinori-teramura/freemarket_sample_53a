class SellController < ApplicationController

  def index
    @item = Item.new
  end

  def create
    # FIXME: 仮置き
    redirect_to :root
  end
end
