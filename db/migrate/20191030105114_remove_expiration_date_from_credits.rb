class RemoveExpirationDateFromCredits < ActiveRecord::Migration[5.2]
  def change
    remove_column :credits, :expiration_date, :date
  end
end
