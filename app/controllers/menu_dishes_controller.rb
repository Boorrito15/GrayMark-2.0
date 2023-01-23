class MenuDishesController < ApplicationController
  def edit
    @menu_dish = MenuDish.find(params[:id])
    @dish = @menu_dish.dish
    @diet = params[:diet]
    @intolerances = params[:intolerances].join(",")
    @allergies = params[:ingredients].join(",")
    @meal_type = params[:meal_type]

    @query = params[:query]
    Spoonacular.new(@query, @cuisine, @diet, @intolerances, @allergies, "main course")
    @schools = School.where(sql_query, query: "%#{params[:query]}%").order('name ASC')
  end
end
