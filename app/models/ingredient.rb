class Ingredient < ApplicationRecord
  has_many :dish_ingredients, dependent: :destroy
  has_many :allergy_profiles, dependent: :destroy
  validates :name, presence: true

  def self.diets
    diets = ["Gluten Free", "Ketogenic", "Vegetarian", "Vegan", "Pescetarian"]
  end

  def self.intolerances
    intolerances = ["Dairy", "Egg", "Gluten", "Grain", "Peanut", "Seafood", "Sesame", "Shellfish", "Soy", "Sulfite", "Tree Nut", "Wheat"]
  end
end
