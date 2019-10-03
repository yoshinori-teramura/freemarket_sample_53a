class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_one :adress
  has_one  :credit
  accepts_nested_attributes_for :adress
  accepts_nested_attributes_for :credit
         
end
