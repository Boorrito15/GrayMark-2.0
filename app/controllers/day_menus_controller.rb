class DayMenusController < ApplicationController
  def edit
    @day_menu = DayMenu.find(params[:id])
    @menu_dishes = MenuDish.where(day_menu: @day_menu)
    @menu_dish = @menu_dishes.find(params[:day_menu_id])
  end
end
