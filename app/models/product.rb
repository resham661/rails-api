class Product < ApplicationRecord
  validates :name, :brand, :price, presence: true
  # validates :brand, presence: true
  # validates :price, presence: true
end
