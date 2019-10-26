class AddDeliveryTelToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :delivery_tel, :integer
  end
end
