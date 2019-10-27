class AddDeliveryFirstNameToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :delivery_first_name, :string
  end
end
