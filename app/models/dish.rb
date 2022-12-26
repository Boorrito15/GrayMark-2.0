class Dish < ApplicationRecord
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients
  validates :name, presence: true, uniqueness: true
  validates :course, presence: true
end
