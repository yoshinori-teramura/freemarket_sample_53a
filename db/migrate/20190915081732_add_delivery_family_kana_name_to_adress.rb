class AddDeliveryFamilyKanaNameToAdress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :delivery_family_kana_name, :string
  end
end
