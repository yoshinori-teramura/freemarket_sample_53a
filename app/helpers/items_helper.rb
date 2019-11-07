module ItemsHelper

  def can_buy_item(item)
    return false if user_signed_in? == false
    return false if item.user.id == current_user.id
    return false if item.trade_status_showing? == false
    return true
  end
end
