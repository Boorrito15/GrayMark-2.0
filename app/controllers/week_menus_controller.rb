class WeekMenusController < ApplicationController
  def index
    @week_menus = WeekMenu.all
  end
end
