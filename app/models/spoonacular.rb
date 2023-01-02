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
# In the original app, a week_menu would use over 15 calls for the menus and 15 more for the ingredients. 1 dish = 2 calls total 30 calls

# We want to get this number down to 1 week_menu = 3 calls and ingredients = 3 calls. 1 dish = 1/5 calls 1 ingredient 1/5 calls total 6 calls
