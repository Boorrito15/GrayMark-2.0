class Spoonacular
  def initialize(cuisine, diet, intolerances, exclude_ingredients, meal_type)
    @cuisine = cuisine
    @diet = diet
    @intolerances = intolerances
    @exclude_ingredients = exclude_ingredients
    @meal_type = meal_type
  end

  def call
    search_recipes
    create_dishes
  end

  private

  def search_recipes
    url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{ENV['SPOONACULAR_API']}&cuisine=#{@cuisine}&diet=#{@diet}&intolerances=#{@intolerances}&exclude_ingredients=#{@exclude_ingredients}&type=#{@meal_type}&number=5&sort=random"
    dish_serialized = URI.open(url).read
    dishes = JSON.parse(dish_serialized)
    @dishes = dishes["results"]
  end

  def create_dishes
    @dish_ids = []
    @dishes_processed = []
    @dishes.each do |dish|
      @dish = Dish.find_or_create_by(id: dish["id"], name: dish["title"], course: @meal_type)
      #If dish is new, create it connect image
      if @dish.previously_new_record?
        file = URI.open(dish["image"])
        @dish.image.attach(io: file, filename: "dish.png", content_type: "image/png")
        @dish.save
        @dish_ids << dish["id"]
      end
      @dishes_processed << @dish
    end
    # Get recipe information
    unless @dish_ids.empty?
      @dish_ids_formatted_api = @dish_ids.join(',')
      url = "https://api.spoonacular.com/recipes/informationBulk?apiKey=#{ENV['SPOONACULAR_API_2']}&ids=#{@dish_ids_formatted_api}"
      ingredients_serialized = URI.open(url).read
      ingredients_raw = JSON.parse(ingredients_serialized)
      @dish_ids.count.times do |n|
        ingredients = ingredients_raw[n]["extendedIngredients"]
        n += 1
        ingredients.each do |ingredient|
          id = ingredient["id"]
          name = ingredient["nameClean"]
          ingredient = Ingredient.find_or_create_by(id: id)
          DishIngredient.new(ingredient: ingredient, dish: @dish)
        end
      end
      return @dishes_processed
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
