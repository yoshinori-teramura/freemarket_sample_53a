class AddSecurityCodeToCredits < ActiveRecord::Migration[5.2]
  def change
    add_column :credits, :security_code, :integer ,null:false
  end
end
