class RemoveNumber2FromCredits < ActiveRecord::Migration[5.2]
  def change
    remove_column :credits, :number, :string
  end
end
