class MenuDishesController < ApplicationController
  def edit
    @menu_dish = MenuDish.find(params[:id])
    @dish = @menu_dish.dish
    @diet = params[:diet]
    @intolerances = params[:intolerances]
    @allergies = params[:ingredients]
    @meal_type = @menu_dish.dish.course
    params[:query].present? ? @query = params[:query] : @query = ""

    @results = Spoonacular.new(@cuisine, @diet, @intolerances, @allergies, @meal_type)
    @results_dishes = @results.search(@query)
  end

  def update
    @menu_dish = MenuDish.find(params[:id])
    @meal_type = @menu_dish.dish.course
    @dish = Dish.find_or_create_by(name: params[:title], id: params[:key], course: @meal_type)
    if @dish.previously_new_record?
      file = URI.open(params["image"])
      @dish.image.attach(io: file, filename: "dish.png", content_type: "image/png")
      @dish.save
      # @ingredients_raw = dish["missedIngredients"]
      # @ingredients_raw.each do |ingredient|
      #   id = ingredient["id"]
      #   name = ingredient["name"]
      #   @ingredient = Ingredient.find_by(id: id)
      #   @ingredient.nil? ? @ingredient = Ingredient.create(id: id, name: name) : @ingredient = Ingredient.find_by(id: id)
      #   DishIngredient.new(ingredient: @ingredient, dish: @dish)
      end

    @menu_dish.update(dish: @dish)
    @week_menu = @menu_dish.day_menu.week_menu
    @profile = @week_menu.profile
    @school = @profile.school
    redirect_to edit_school_profile_week_menu_path(@school, @profile, @week_menu)
  end
end
