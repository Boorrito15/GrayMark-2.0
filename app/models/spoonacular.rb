class Spoonacular < ApplicationRecord
  def initialize(cuisine, diet, intolerances, excludeIngredients, mealtype)
    @cuisine = cuisine
    @diet = diet
    @intolerances = intolerances
    @excludeIngredients = excludeIngredients.map { |id| Ingredient.find(id).name }.join(", ")
    @mealtype = mealtype
  end

  def get_recipes
    url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{ENV['SPOONACULAR_API']}&cuisine=#{@cuisine}&diet=#{@diet}&intolerances=#{@intolerances}&excludeIngredients=#{@excludeIngredients}&type=#{@mealtype}"
    dish_serialized = URI.open(url).read
    dishes = JSON.parse(dish_serialized)
    @dish_api_info = dishes["results"].sample
  end

  def create_dishes
  end
end
