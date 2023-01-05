class Spoonacular < ApplicationRecord
  def initialize(cuisine, diet, intolerances, excludeIngredients, mealtype)
    @cuisine = cuisine
    @diet = diet
    @intolerances = intolerances
    @excludeIngredients = excludeIngredients.map { |id| Ingredient.find(id).name }.join(", ")
    @mealtype = mealtype
  end

  def search_recipes
    url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{ENV['SPOONACULAR_API']}&cuisine=#{@cuisine}&diet=#{@diet}&intolerances=#{@intolerances}&excludeIngredients=#{@excludeIngredients}&type=#{@mealtype}"
    dish_serialized = URI.open(url).read
    dishes = JSON.parse(dish_serialized)
    @dishes = dishes["results"].sample[5]
  end

  def create_dishes
    @dishes.each do |dish|
      @dish = Dish.find_or_create_by(id: dish["id"], name: dish["title"], course: @mealtype)
      #If dish is new, create it connect image
      if @dish.previously_new_record?
        file = URI.open(dish["image"])
        @dish.image.attach(io: file, filename: "dish.png", content_type: "image/png")
        @dish.save
        @dish_ids = []
        @dish_ids << dish.id
      end
    end
    if !@dish_ids.empty?
      @dish_ids_formatted_api = @dish_ids.join(',')
      url = "https://api.spoonacular.com/recipes/informationBulk?apiKey=#{ENV['SPOONACULAR_API']}&ids=#{@dish_ids_formatted_api}"
      ingredients_serialized = URI.open(url).read
      ingredients_raw = JSON.parse(ingredients_serialized)
      n = 0
      @dish_ids.each do |dish, n|
        ingredients = ingredients_raw[n]["extendedIngredients"]
        n+=1
        ingredients.each do |ingredient|
          id = ingredient["id"]
          name = ingredient["nameClean"]
          ingredient = Ingredient.find_or_create_by(id: id, name: name)
          DishIngredient.new(ingredient: ingredient, dish: @dish)
        end
      end
    end
  end
end
# In the original app, 1 allergy_profile/week_menu would use over 30 calls
# 15 dishes = 15 calls
# 15 ingredient sets = 15 calls

# This app, 1 allergy_profile/week_menu would use 6 calls
# 15 dishes = 3 calls
# 15 ingredient sets = 3 calls

# This is then multiplied by the number of terms and intervals.
# A school has 3 terms and 4 intervals in a term
# 1 year of menus would equal to 180 calls OR 48 calls per allergy profile

# But we can make it even more efficient
