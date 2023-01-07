class SchoolsController < ApplicationController
  def index
    @schools = School.where(user: current_user)
  end

  def show
    @school = School.find(params[:id])
    @profiles = Profile.where(school: @school)
    # @week_menus = []
    # @intolerance_profiles = []
    # @allergy_profiles = []
    # @intolerances = []
    # @allergies = []

    # @profiles.each do |profile|
    #   @week_menus << WeekMenu.where(profile: profile)
    #   IntoleranceProfile.where(profile: profile).each do |profile|
    #     @intolerances << profile.intolerance.name
    #   end
    #   AllergyProfile.where(profile: profile).each do |profile|
    #     @allergies << profile.ingredient.name
    #   end
    #   # raise




    # @week_menus_by_date = @week_menus.flatten.group_by { |week_menu| week_menu.date}
  end
end
