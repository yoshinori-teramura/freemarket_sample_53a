class AddParamsToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :user, foreign_key: true
    add_reference :items, :category, foreign_key: true
    add_reference :items, :brand, foreign_key: true
    add_column :items, :shipping_charge, :integer
    add_column :items, :derivery_region, :integer
    add_column :items, :derivery_days, :integer
    add_column :items, :delivery_type, :integer
    add_column :items, :item_status, :integer
    add_column :items, :trade_status, :integer
  end
end
