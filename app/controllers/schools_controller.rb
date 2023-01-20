class SchoolsController < ApplicationController
  def index
    @schools = School.where(user: current_user).order(name: :asc)
  end

  def search
    @schools = School.all.order('name ASC')
  end

  def show
    @school = School.find(params[:id])
    @school.user.nil? ? @dietician = nil : @dietician = @school.user.first_name << " " << @school.user.last_name
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

  def assign_school
    @school = School.find(params[:id])
    @school.update(user: current_user)
    redirect_to schools_path
    flash.alert = "#{@school.name} has been added to your schools"
  end
end
