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
end
