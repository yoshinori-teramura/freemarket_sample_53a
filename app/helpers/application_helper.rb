module ApplicationHelper

  def to_yen(number)
    return '¥' + number.to_s(:delimited, delimiter: ',')
  end
end
