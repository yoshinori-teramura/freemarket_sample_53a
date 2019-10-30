class Address < ApplicationRecord
  belongs_to :user

  validates :postal_code ,presence: true
  validates :city ,presence: true
  validates :block ,presence: true
  validates :delivery_first_name, presence: true
  validates :delivery_family_name ,presence: true
  validates :delivery_first_kana_name ,presence: true
  validates :delivery_family_kana_name , presence: true
  validates :prefecture_id, presence: true
end
