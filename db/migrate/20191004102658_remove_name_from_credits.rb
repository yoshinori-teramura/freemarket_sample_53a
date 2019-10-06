class RemoveNameFromCredits < ActiveRecord::Migration[5.2]
  def change
    remove_column :credits, :name, :string
  end
end
