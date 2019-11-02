class AddCardIdToCredits < ActiveRecord::Migration[5.2]
  def change
    add_column :credits, :card_id, :string
  end
end
