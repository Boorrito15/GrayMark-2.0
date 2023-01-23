class MenuDishesController < ApplicationController
  def edit
    @menu_dish = MenuDish.find(params[:id])
    @dish = @menu_dish.dish
    @diet = params[:diet]
    @intolerances = params[:intolerances].join(",")
    @allergies = params[:ingredients].join(",")
    @meal_type = params[:meal_type]

    @query = params[:query]
    if params[:query].present?
      @results = Spoonacular.new(@query, @cuisine, @diet, @intolerances, @allergies, @meal_type)
      @results_dishes = @results.search_recipes_query
    else
      Dish.all
    end

  end
end
