class WeekMenusController < ApplicationController
  def index
    profile_id = @school.id.profile_id
    @week_menus = WeakMenu.where(profile_id)
  end
end
