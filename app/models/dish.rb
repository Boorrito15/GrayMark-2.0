class Dish < ApplicationRecord
  has_many :dish_ingredients, dependent: :destroy
  has_many :ingredients, through: :dish_ingredients, dependent: :destroy
  has_many :menu_dishes, dependent: :destroy
  has_many :day_menus, through: :menu_dishes
  validates :name, presence: true, uniqueness: true
  validates :course, presence: true
  has_one_attached :image
end
