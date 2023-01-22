class ProfilesController < ApplicationController
  before_action :set_school, only: %i[index new create]
  before_action :set_profile, only: %i[edit update]
  
  def index
    @profiles = Profile.where(school: @school)
    @active_profiles = @profiles.where(active: true)
    @inactive_profiles = @profiles.where(active: false)
  end

  def new
    @profile = Profile.new(school: @school)
  end

  def create
    @diet = Diet.find_by(id: params[:diet].to_i)
    @intolerances = params[:intolerances].reject { |i| i.blank? }.sort
    @allergies = params[:ingredients].reject { |i| i.blank? }.sort
    @active = params[:active]

    @profiles = @school.profiles.where(diet: @diet)
    @profile_intolerance = @profiles.joins(:intolerance_profiles).where(intolerance_profiles: { intolerance_id: @intolerances }).distinct
    @profile = @profile_intolerance.joins(:allergy_profiles).where(allergy_profiles: { ingredient_id: @allergies }).distinct


    if @profile.empty?
      @profile = Profile.create!(school: @school, diet: @diet, active: @active)
      unless @intolerances.nil?
        @intolerances.each do |intolerance|
          IntoleranceProfile.create(profile: @profile, intolerance: Intolerance.find_by(id: intolerance))
        end
      end
      unless @allergies.nil?
        @allergies.each do |allergy|
          AllergyProfile.create(profile: @profile, ingredient: Ingredient.find_by(id: allergy))
        end
      end
      flash.alert = "This profile has been added to #{@school.name}."
      redirect_to school_profiles_path(@school)
    else
      flash.alert = "This profile already exists for this #{@school.name}."
    end
  end

  def edit
    @school = @profile.school
    if @profile.diet.nil?
      @diet = ""
    else
      @diet = @profile.diet
    end
    @intolerances_name = @profile.intolerances.map(&:name)
    @allergies_name = @profile.ingredients.map(&:name)
    @intolerances = @profile.intolerances.map
    @allergies = @profile.ingredients.map
    @active = @profile.active
  end

  def update
    @diet = Diet.find(params[:diet])
    @intolerances = params[:intolerances].reject { |i| i.blank? }.sort
    @allergies = params[:ingredients].reject { |i| i.blank? }.sort
    @active = params[:active]

    if @profile.diet == @diet && @profile.intolerances.map(&:id) == @intolerances && @profile.ingredients.map(&:id) == @allergies
    elsif @profile.diet != @diet
      @profile.update(diet: @diet, active: @active)
    else
      @profile.update(diet: @diet, active: @active)
      @profile.intolerance_profiles.destroy_all
      @intolerances.each do |intolerance|
        IntoleranceProfile.create(profile: @profile, intolerance: Intolerance.find_by(id: intolerance))
      end
      @profile.allergy_profiles.destroy_all
      @allergies.each do |allergy|
        AllergyProfile.create(profile: @profile, ingredient: Ingredient.find_by(id: allergy))
      end
    end
    flash.alert = "Profile has been updated successfully."
    redirect_to school_profiles_path(@profile.school)
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
