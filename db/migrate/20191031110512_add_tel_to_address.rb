class AddTelToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :delivery_tel, :string
  end
end
