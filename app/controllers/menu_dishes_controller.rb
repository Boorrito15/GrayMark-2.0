class MenuDishesController < ApplicationController
  def edit
    @menu_dish = MenuDish.find(params[:id])
  end
end
