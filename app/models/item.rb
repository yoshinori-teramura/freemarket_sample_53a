class Item < ApplicationRecord
  validates :description, presence: true, unless: :image?

  mount_uploader :image, ImageUploader
end
