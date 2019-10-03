class AddUseIdToAdress < ActiveRecord::Migration[5.2]
  def change
    add_reference :adresses, :user, foreign_key: true
  end
end
