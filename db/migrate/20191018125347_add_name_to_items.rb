class AddNameToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :name, :string
    add_column :items, :price, :integer
  end
end
