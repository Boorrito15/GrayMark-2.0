class SchoolsController < ApplicationController
  def index
    @schools = School.where(user: current_user)
  end

  def show
    @school = School.find(params[:id])
    @active_profiles = Profile.where(school: @school, active: true)

    @week_menus = []

    # SHOW PROFILES
    # @intolerance_profiles = []
    # @allergy_profiles = []
    @intolerances = []
    @allergies = []

    @active_profiles.each do |profile|
      @week_menus << WeekMenu.where(profile: profile)

      IntoleranceProfile.where(profile: profile).each do |intolerance_profile|
        @intolerances << intolerance_profile.intolerance.name
      end
      AllergyProfile.where(profile: profile).each do |allergy_profile|
        @allergies << allergy_profile.ingredient.name
      end
    end

    # SHOW MENUS
    # SHOW THE MOST RECENT MENU OR SHOW THE MENU THAT FALLS WITHIN THE THREE WEEKS
    # week menu >> profile >> allergy profile
    # @menu_intolerance_profiles = []
    # @menu_allergy_profiles = []
    @menu_intolerances = []
    @menu_allergies = []

    @current_menus = @week_menus.flatten.select { |week_menu| week_menu.date > Date.today-30 }
    @current_menus.each do |menu|
      menu_profile = menu.profile
      IntoleranceProfile.where(profile: menu_profile).each do |intolerance_profile|
        @menu_intolerances << intolerance_profile.intolerance.name
      end
      AllergyProfile.where(profile: menu_profile).each do |allergy_profile|
        @menu_allergies << allergy_profile.ingredient.name
      end
    end


    @week_menus_by_date = @week_menus.flatten.group_by { |week_menu| week_menu.date }
    
  end
end
