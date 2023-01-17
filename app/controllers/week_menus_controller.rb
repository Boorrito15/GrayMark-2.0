require "json"
require "open-uri"

class WeekMenusController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @week_menus = WeekMenu.joins(:profile).where(profiles: { school: @school, active: true })
    @profiles = Profile.where(school: @school, active: true)
    @current_menus = @week_menus.select { |week_menu| week_menu.date > Date.today - 21 }
    @past_menus = @week_menus.select { |week_menu| week_menu.date < Date.today - 21 }
  end

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
    @school = School.find(params[:school_id])
    @profiles = Profile.where(school: @school, active: true)
    @week_menu = WeekMenu.new
  end

  def create
    @school = School.find(params[:school_id])
    @date = Date.parse(params[:date])

    @cuisine = params[:cuisine]
    @profiles = Profile.where(school: @school, active: true)

    unless @profiles.empty?
      @profiles.each do |profile|
        @week_menu = WeekMenu.create(profile: profile, date: @date)
        if profile.diet.nil?
          @diet = ""
        else
          @diet = profile.diet.name
        end

        @intolerances = profile.intolerances.map(&:name).join(',')
        @allergies = profile.ingredients.map(&:name).join(',')

        # For each profile create 15 Dishes

        @main = Spoonacular.new(@cuisine, @diet, @intolerances, @allergies, "main course")
        @main_dishes = @main.call

        @side = Spoonacular.new(@cuisine, @diet, @intolerances, @allergies, "side dish")
        @side_dishes = @side.call

        @dessert = Spoonacular.new(@cuisine, @diet, @intolerances, @allergies, "dessert")
        @dessert_dishes = @dessert.call

        # For each day, assign 3 dishes (1 for each mealtype)

        0.upto(4) do |n|
          date = @date + n.days
          @day_menu = DayMenu.create(date: date, week_menu: @week_menu)
          MenuDish.create(day_menu: @day_menu, dish: @main_dishes[n])
          MenuDish.create(day_menu: @day_menu, dish: @side_dishes[n])
          MenuDish.create(day_menu: @day_menu, dish: @dessert_dishes[n])
        end
      end
    end
  end
  # https://api.spoonacular.com/recipes/complexSearch?apiKey=99c01005a66940b5a1c9b6e6cfed1ef7&diet=vegetarian&excludeIngredients=Tomatoes,Walnuts&type=main course
end


















# @diet = params[:week_menu][:diet]
# @intolerances = params[:week_menu][:intolerances]
# @allergies = params[:week_menu][:ingredient]

# profile = @week_menu.profiles.joins(:allergy_profiles).where(allergy_profiles: { ingredient_id: @allergies }).group('profiles.id').having('count(profiles.id) >= ?', @allergies.size)

# @allergy_profiles = AllergyProfile.where(profile: profile)
# # this gives me an array of allergy_profiles, but what we want is to get the ingredients
# @ingredients = @allergy_profiles.map(&:ingredient)
# # if allergies and ingredients don't match then (regardless of order), create a new profile and menu
# if @allergies.sort != @ingredients.sort
#   @new_profile = Profile.create(school: @school)
#   @new_allergy_profiles = @allergies.map { |allergy| AllergyProfile.create(profile: @new_profile, ingredient: allergy) }
#   # create menu with the new profile
#   @new_week_menu = WeekMenu.create(profile: @new_profile, date: @date)
#     # create 5 day menus
#     # if allergies and ingredients match but dates are different, then create a new menu but assign the same profile
#     @week_menus = WeekMenu.where(profile: @profile)
#     @dates = @week_menus.map(&:date)
# elsif @dates.exlcude?(@date)
#   WeekMenu.create(profile: @new_profile, date: @date)
#     # if allergies and ingredients matches but dates are the same, then redirect to existing menu
# else
#   redirect_to week_menu_path(WeekMenu.find_by(date: @date, profile: @profile))
# end


# TO-DO: create 5 day_menus for Monday to Friday
  # TO-DO: create 3 dishes for each day_menu (1 dish for each course) (Spoonacular API)
