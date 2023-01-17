class ProfilesController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    @profiles = Profile.where(school: @school)
    @active_profiles = @profiles.where(active: true)
    @inactive_profiles = @profiles.where(active: false)
  end

  def new
    @school = School.find(params[:school_id])
    @profile = Profile.new(school: @school)
  end

  def create
    # USER INPUT FROM FORM
    @school = School.find(params[:school_id])
    @diet = Diet.find_by(id: params[:diet].to_i)
    @intolerances = params[:intolerances].reject { |i| i.blank? }.sort
    @allergies = params[:ingredients].reject { |i| i.blank? }.sort
    @active = params[:active]

    # FIND IF PROFILE EXISTS
    # 1) List all profiles that belong to "Cheam" and is "Vegetarian"
    @profiles = @school.profiles.where(diet: @diet)
    # 2) Are there any profiles with the same intolerances?
    @profile_intolerance = @profiles.joins(:intolerance_profiles).where(intolerance_profiles: {intolerance_id: @intolerances}).distinct
    # 3) If so, are there any profiles with the same ingredients
    @profile = @profile_intolerance.joins(:allergy_profiles).where(allergy_profiles: {ingredient_id: @allergies} ).distinct

    # IF PROFILE DOES NOT EXIST, MAKE IT
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
      # IF PROFILE EXISTs, GO TO IT
    else
      flash.alert = "This profile already exists for this #{@school.name}."
    end
  end

  def edit
    @profile = Profile.find(params[:id])
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
    @profile = Profile.find(params[:id])
    @diet = Diet.find(params[:diet])
    @intolerances = params[:intolerances].reject { |i| i.blank? }.sort
    @allergies = params[:ingredients].reject { |i| i.blank? }.sort
    @active = params[:active]

    # IF NOTHING CHANGES
    if @profile.diet == @diet && @profile.intolerances.map(&:id) == @intolerances && @profile.ingredients.map(&:id) == @allergies
    # IF ONLY ACTIVE IS CHANGES, DON'T DELETE ASSOCIATED WEEK_MENUS, INTOLERANCE, AND ALLERGY PROFILES
    elsif @profile.diet != @diet
      @profile.update(diet: @diet, active: @active)

    # IF DIET, INTOLERANCES, OR ALLERGIES CHANGE, DELETE ASSOCIATED WEEK_MENUS, INTOLERANCE, AND ALLERGY PROFILES AND CREATE NEW ONES
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

    # raise
    flash.alert = "Profile has been updated successfully."
    redirect_to school_profiles_path(@profile.school)
  end
end
