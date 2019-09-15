class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.references :user,      null:false,foreign_key: true
      t.integer    :number,       null:false,unique: true
      t.string     :name,         null:false
      t.date       :expiration_date,  null:false
      
      # t.timestamps
    end
  end
end
