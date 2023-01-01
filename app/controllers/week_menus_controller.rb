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

  def new
    @week_menu = WeekMenu.new
  end

  def create
    # take in dietician inputs
    @school = School.find_by(name: "Cheam")
    @date = Date.new(2022, 12, 26)
    @allergies = [Ingredient.find_by(name: "Tomatoes"), Ingredient.find_by(name: "Walnuts")]

    # check if the profile already exists
    @profile = Profile.find_by(school: @school)

    # if profile doesn't exist, create a new one. This is for creating a menu for the very first time
    if @profile.empty?
      @new_profile = Profile.create[school: @school]
      @ingredients = []
      @allergies.each do |allergy|
        @new_allergy_profile = AllergyProfile.create[profile: @new_profile, ingredient: allergy]
        @ingredients << @new_allergy_profile
      end
    # if profile exists, pull up the allergy profiles of that profile
    else
      @allergy_profiles = AllergyProfile.where(profile: @profile)
      # this gives me an array of allergy_profiles, but what we want is to get the ingredients
      @ingredients = []
      # pull up the ingredients for each allergy profile
      @allergy_profiles.each do |allergy_profile|
        @ingredients << allergy_profile.ingredient
      end
    end
    # if allergies and ingredients don't match then, create a new profile and menu
    if @allergies != @ingredients
      @new_profile = Profile.create[school: @school]
      @allergies.each do |allergy|
        AllergyProfile.create[profile: @new_profile, ingredient: allergy]
      end
      # create menu
      WeekMenu.create[profile: @new_profile, date: @date]
      # if allergies and ingredients matches but dates are different, then create a new menu but assign the same profile
      @week_menus = WeekMenu.where(profile: @profile)
      @dates []
      @week_menus.each do |week_menu|
        @dates << week_menu.date
      end
    elsif @dates.exlcude?(@date)
      WeekMenu.create[profile: @new_profile, date: @date]
      # if allergies and ingredients matches but dates are the same, then redirect to existing menu
    else
      redirect_to week_menu_path(WeekMenu.find_by(date: @date, profile: @profile))
    end
  end
end

# TO-DO: create 5 day_menus for Monday to Friday
  # TO-DO: create 3 dishes for each day_menu (1 dish for each course) (Spoonacular API)
