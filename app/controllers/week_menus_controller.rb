require "json"
require "open-uri"

class WeekMenusController < ApplicationController
  before_action :set_school, only: %i[index new create review]
  before_action :set_week_menu, only: %i[show update_status edit]

  def index
    @week_menus = WeekMenu.joins(:profile).where(profiles: { school: @school, active: true })
    @profiles = Profile.where(school: @school, active: true)
    @current_menus = @week_menus.select { |week_menu| week_menu.date > Date.today - 21 }
    @past_menus = @week_menus.select { |week_menu| week_menu.date < Date.today - 21 }
  end

  def show
    @profile = @week_menu.profile
    @school = @week_menu.profile.school
    @diet = @profile.diet.name
    @intolerances = @profile.intolerances.map(&:name)
    @allergies = @profile.ingredients.map(&:name)
    @day_menus = DayMenu.where(week_menu: @week_menu)
    @day_menus_ordered = @day_menus.in_order_of(:meal_type, [ "main course", "side dish", "dessert" ])
    @day_menus_grouped_by_day = @day_menus.group_by { |day_menu| day_menu.date.strftime("%A") }
  end

  def new
    @profiles = Profile.where(school: @school, active: true)
    @week_menu = WeekMenu.new
  end

  def create
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

        @main = Spoonacular.new(@cuisine, @diet, @intolerances, @allergies, "main course")
        @main_dishes = @main.call

        @side = Spoonacular.new(@cuisine, @diet, @intolerances, @allergies, "side dish")
        @side_dishes = @side.call

        @dessert = Spoonacular.new(@cuisine, @diet, @intolerances, @allergies, "dessert")
        @dessert_dishes = @dessert.call

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
    @week_menus_pending = @week_menus.where(status: nil) && @week_menus.where(status: false)
    @week_menus_approved = @week_menus.where(status: true)
  end

  def update_status
    @school = @week_menu.profile.school
    @week_menu.update(status: !@week_menu.status)
    redirect_to edit_school_week_menu_path(@school, @week_menu), notice: "Menu has been updated"
  end

  def edit
    @profile = @week_menu.profile
    @school = @week_menu.profile.school
    @diet = @profile.diet.name
    @intolerances = @profile.intolerances.map(&:name)
    @allergies = @profile.ingredients.map(&:name)
    @day_menus = DayMenu.where(week_menu: @week_menu)
    @day_menus_ordered = @day_menus.in_order_of(:meal_type, [ "main course", "side dish", "dessert" ])
    @day_menus_grouped_by_day = @day_menus.group_by { |day_menu| day_menu.date.strftime("%A") }
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_week_menu
    @week_menu = WeekMenu.find(params[:id])
  end
end
