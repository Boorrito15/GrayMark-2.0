class Ingredient < ApplicationRecord
  has_many :dish_ingredients, dependent: :destroy
  has_many :allergy_profiles, dependent: :destroy
  validates :name, presence: true
end
