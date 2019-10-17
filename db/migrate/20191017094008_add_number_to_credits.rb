class AddNumberToCredits < ActiveRecord::Migration[5.2]
  def change
    add_column :credits, :number, :string  ,null:false
  end
end
