class ListingsController < ApplicationController
  before_action :authenticate_user!

  def listing
    @items = current_user.items
      .where(trade_status: :showing)
      .or(current_user.items.where(trade_status: :suspend))
      .limit(5)
  end

  def in_progress
    @items = current_user.items
      .where(trade_status: :trading)
      .limit(5)
  end

  def completed
    @items = current_user.items
      .where(trade_status: :sold)
      .limit(5)
  end
end
