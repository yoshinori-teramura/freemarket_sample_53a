class ItemPriceValidator < ActiveModel::Validator

  def validate(record)
    unless 300 <= record.price && record.price <= 9999999
      record.errors.add :base, "priceが範囲内でありません"
    end
  end

end