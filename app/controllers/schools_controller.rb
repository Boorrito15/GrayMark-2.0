class SchoolsController < ApplicationController
  def index
    @schools = School.where(user: current_user)
  end

  def show
    @school = School.find(params[:id])
    @profiles = Profile.where(school: @school)
    @intervals = @school.week_menus.group_by { |week_menu| week_menu.date }
  end
end
