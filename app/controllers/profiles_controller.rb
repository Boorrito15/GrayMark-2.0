class ProfilesController < ApplicationController
  def new
    @school = School.find(params[:school_id])
    @profile = Profile.new(school: @School)
  end

  def create
    @diet = params[:profile][:diet]
    @intolerances = params[:profile][:intolerances]
    @allergies = params[:profile][:ingredients]

    @profile = Profile.create(school: @school, diet: @diet)

    unless @intolerances.empty?
      @intolerances.each do |intolerance|
      IntoleranceProfile.create(profile: @profile, ingredient: intolerance)
      end
    end

    unless @allergies.empty?
      @allergies.each do |allergy|
        AllergyProfile.create(profile: @profile, ingredient: allergy)
      end
    end
  end
end
