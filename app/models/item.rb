class Item < ApplicationRecord
  validates :description, presence: true, unless: :image?

  mount_uploader :image, ImageUploader

  # belongs_to :user

  def previous
    Item.order('id desc')
        .where('id < ?', id)
        .first
  end

  def next
    Item.order('id desc')
        .where('id > ?', id)
        .reverse.first
  end
end
