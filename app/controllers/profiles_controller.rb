class ProfilesController < ApplicationController
  def new
    @school = School.find(params[:school_id])
    @profile = Profile.new(school: @School)
  end

  def create
    # USER INPUT FROM FORM
    @school = School.find(params[:school_id])
    @diet = Diet.find_by(id: params[:diet].to_i)
    @intolerances = params[:intolerances].reject { |i| i.blank? }.sort
    @allergies = params[:ingredients].reject { |i| i.blank? }.sort

    # FIND IF PROFILE EXISTS
      # 1) List all profiles that belong to "Cheam" and is "Vegetarian"
    @profiles = @school.profiles.where(diet: @diet)
      # 2) Are there any profiles with the same intolerances?
    @profile_intolerance = @profiles.joins(:intolerance_profiles).where(intolerance_profiles: {intolerance_id: @intolerances}).distinct
      # 3) If so, are there any profiles with the same ingredients
    @profile = @profile_intolerance.joins(:allergy_profiles).where(allergy_profiles: {ingredient_id: @allergies}).uniq

    # IF PROFILE DOES NOT EXIST, MAKE IT
    if @profile.empty?
      @profile = Profile.create!(school: @school, diet: @diet)
      unless @intolerances.empty?
        @intolerances.each do |intolerance|
          IntoleranceProfile.create(profile: @profile, intolerance: Intolerance.find_by(id: intolerance))
        end
      end
      unless @allergies.empty?
        @allergies.each do |allergy|
          AllergyProfile.create(profile: @profile, ingredient: Ingredient.find_by(id: allergy))
        end
      end
      flash.alert = "This profile has been added to #{@school.name}."
      redirect_to school_path(@school)
    # IF PROFILE EXISTs, GO TO IT
    else
      flash.alert = "This profile already exists for this #{@school.name}."
      redirect_to school_path(@school)
    end
  end
end
