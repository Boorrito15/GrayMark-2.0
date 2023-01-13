class SchoolsController < ApplicationController
  def index
    @schools = School.where(user: current_user)
  end

  def show
    @school = School.find(params[:id])
    @profiles = Profile.where(school: @school, active: true)
    @week_menus = []
    @intolerance_profiles = []
    @allergy_profiles = []
    @intolerances = []
    @allergies = []

    @profiles.each do |profile|
      @week_menus << WeekMenu.where(profile: profile)
      IntoleranceProfile.where(profile: profile).each do |intolerance_profile|
        @intolerances << intolerance_profile.intolerance.name
      end
      AllergyProfile.where(profile: profile).each do |allergy_profile|
        @allergies << allergy_profile.ingredient.name
      end
    end
      # raise
    @week_menus_by_date = @week_menus.flatten.group_by { |week_menu| week_menu.date}
  end
end
