class AddDeliveryFamilyNameToAdress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :delivery_family_name, :string
  end
end
