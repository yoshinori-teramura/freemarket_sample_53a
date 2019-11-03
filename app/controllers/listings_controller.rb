class ListingsController < ApplicationController
  before_action :authenticate_user!

  def listing
    # TODO:ページネーション対応
    @items = current_user.items
      .where(trade_status: :showing)
      .or(current_user.items.where(trade_status: :suspend))
  end

  def in_progress
    # TODO:ページネーション対応
    @items = current_user.items
      .where(trade_status: :trading)
  end

  def completed
    # TODO:ページネーション対応
    @items = current_user.items
      .where(trade_status: :sold)
  end
end
