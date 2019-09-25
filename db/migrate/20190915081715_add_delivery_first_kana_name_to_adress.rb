class AddDeliveryFirstKanaNameToAdress < ActiveRecord::Migration[5.2]
  def change
    add_column :adresses, :delivery_first_kana_name, :string
  end
end
