class RemoveTelfromAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :delivery_tel, :integer
  end
end
