class AddDeliveryFirstNameToAdress < ActiveRecord::Migration[5.2]
  def change
    add_column :adresses, :delivery_first_name, :string
  end
end
