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
    @day_menus_ordered = @day_menus.in_order_of(:meal_type, [ "main course", "side dish", "dessert" ])
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
        @week_menu = WeekMenu.create(profile: profile, date: @date, status: false)
        if profile.diet.nil?
          @diet = ""
        else
          @diet = profile.diet.name
        end

        @intolerances = profile.intolerances.map(&:name).join(',')
        @allergies = profile.ingredients.map(&:name).join(',')

        # For each profile create 15 Dishes
        # TO-DO: Refactor into one call for all mealtypes

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
      redirect_to review_school_week_menus_path(@school)
    else
      redirect_to profile school_profiles_path(@school)
    end
  end

  def review
    @week_menus = WeekMenu.joins(:profile).where(profiles: { school: @school, active: true })
    @week_menus_pending = @week_menus.where(status: false) || @week_menus.where(status: empty?)
    @week_menus_approved = @week_menus.where(status: true)
  end

  def edit
    @week_menus = WeekMenu.joins(:profile).where(profiles: { school: @school, active: true })
    @week_menus_pending = @week_menus.where(status: false) || @week_menus.where(status: empty?)
    @week_menus_approved = @week_menus.where(status: true)
    @week_menu = WeekMenu.find(params[:id])
  end
end

  # TO-DO: create 3 dishes for each day_menu (1 dish for each course) (Spoonacular API)
