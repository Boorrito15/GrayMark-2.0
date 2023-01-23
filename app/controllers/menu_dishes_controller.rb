class MenuDishesController < ApplicationController
  def edit
    @menu_dish = MenuDish.find(params[:id])
    @dish = @menu_dish.dish
    @diet = params[:diet]
    @intolerances = params[:intolerances].join(",")
    @allergies = params[:ingredients].join(",")
  end
end
