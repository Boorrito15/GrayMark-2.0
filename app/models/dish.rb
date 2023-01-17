class Dish < ApplicationRecord
  has_many :dish_ingredients, dependent: :destroy
  has_many :ingredients, through: :dish_ingredients, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :course, presence: true
  has_one_attached :image
end
