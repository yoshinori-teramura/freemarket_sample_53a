class RemovePrefectureFromAdresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :adresses, :prefecture, :string
  end
end
