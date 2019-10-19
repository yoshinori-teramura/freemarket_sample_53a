module ApplicationHelper

  def to_yen(number)
    price = number.present? ? number : 0
    return '¥' + price.to_s(:delimited, delimiter: ',')
  end
end
