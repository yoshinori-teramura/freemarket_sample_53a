class CreateAdresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|

      t.integer :postal_code,       null:false
      t.string  :prefecture,        null:false
      t.string  :city,              null:false
      t.string  :block,             null:false
      t.string  :building_name

      # t.timestamps
    end
  end
end
