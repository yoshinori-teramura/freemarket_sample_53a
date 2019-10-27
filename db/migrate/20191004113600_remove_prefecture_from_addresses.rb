class RemovePrefectureFromAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :prefecture, :string
  end
end
