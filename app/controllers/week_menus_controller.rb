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
    # @profile = Profile.find(params[:profile_id])
  end

  def create
    # take in dietician inputs PLACEHOLDER FOR TESTING
    # @cuisine = "British"
    @profiles = Profile.where(school: "Cheam")
    # @date = Date.new(2022, 12, 26)
    # @allergies = [Ingredient.find_by(name: "Tomatoes"), Ingredient.find_by(name: "Walnuts")]

    # take in dietician inputs DYNAMIC FOR PRODUCTION NEED CLAIRE'S HELP
    @date = params[:week_menu][:date]
    @cuisine = params[:week_menu][:cuisine]
    @diet = params[:week_menu][:diet]
    @intolerances = params[:week_menu][:intolerances]
    @allergies = params[:week_menu][:ingredient]

    profile = @week_menu.profiles.joins(:allergy_profiles).where(allergy_profiles: { ingredient_id: @allergies }).group('profiles.id').having('count(profiles.id) >= ?', @allergies.size)
    
    @allergy_profiles = AllergyProfile.where(profile: profile)
    # this gives me an array of allergy_profiles, but what we want is to get the ingredients
    @ingredients = @allergy_profiles.map(&:ingredient)
    # if allergies and ingredients don't match then (regardless of order), create a new profile and menu
    if @allergies.sort != @ingredients.sort
      @new_profile = Profile.create(school: @school)
      @new_allergy_profiles = @allergies.map { |allergy| AllergyProfile.create(profile: @new_profile, ingredient: allergy) }
      # create menu with the new profile
      @new_week_menu = WeekMenu.create(profile: @new_profile, date: @date)
        # create 5 day menus
        # if allergies and ingredients match but dates are different, then create a new menu but assign the same profile
        @week_menus = WeekMenu.where(profile: @profile)
        @dates = @week_menus.map(&:date)
    elsif @dates.exlcude?(@date)
      WeekMenu.create(profile: @new_profile, date: @date)
        # if allergies and ingredients matches but dates are the same, then redirect to existing menu
    else
      redirect_to week_menu_path(WeekMenu.find_by(date: @date, profile: @profile))
    end
  end
end


# TO-DO: create 5 day_menus for Monday to Friday
  # TO-DO: create 3 dishes for each day_menu (1 dish for each course) (Spoonacular API)
