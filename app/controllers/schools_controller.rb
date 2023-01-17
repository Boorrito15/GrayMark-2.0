class SchoolsController < ApplicationController
  def index
    @schools = School.where(user: current_user)
  end

  def show
    @school = School.find(params[:id])
    @active_profiles = Profile.where(school: @school, active: true)
    @week_menus = WeekMenu.joins(:profile).where(profiles: { school: @school, active: true })
    @intolerances = []
    @allergies = []

    @active_profiles.each do |profile|
      IntoleranceProfile.where(profile: profile).each do |intolerance_profile|
        @intolerances << intolerance_profile.intolerance.name
      end
      AllergyProfile.where(profile: profile).each do |allergy_profile|
        @allergies << allergy_profile.ingredient.name
      end
    end

    @current_menus = @week_menus.select { |week_menu| week_menu.date > Date.today - 21 }

    @week_menus_by_date = @week_menus.group_by { |week_menu| week_menu.date }
  end
end
