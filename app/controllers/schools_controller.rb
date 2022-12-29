class SchoolsController < ApplicationController
  def index
    @schools = School.where(user: current_user)
  end

  def show
    @school = School.find(params[:id])

    @profiles = Profile.where(school: @school)

    @week_menus = []
    @profiles.each do |profile|
      @week_menus << WeekMenu.where(profile: profile)
    end

    @week_menus_by_date = @week_menus.flatten.group_by { |week_menu| week_menu.date}
  end
end
