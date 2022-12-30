class WeekMenusController < ApplicationController
  def show

    @week_menu = WeekMenu.find(params[:id])
    @school = @week_menu.profile.school
    @day_menus = DayMenu.where(week_menu: @week_menu)
    @day_menus_grouped_by_day = @day_menus.group_by { |day_menu| day_menu.date.strftime("%A") }

    @ingredients = []
    @week_menu.profile.allergy_profiles.each do |allergy_profile|
      @ingredients << allergy_profile.ingredient.name.capitalize
    end
  end
end
