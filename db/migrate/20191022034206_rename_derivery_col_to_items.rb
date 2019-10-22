class RenameDeriveryColToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :derivery_region, :delivery_region
    rename_column :items, :derivery_days, :delivery_days
  end
end
