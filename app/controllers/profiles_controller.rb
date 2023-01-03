class ProfilesController < ApplicationController
  def new
    @school = School.find(params[:school_id])
    @profile = Profile.new(school: @School)
  end

  def create
    @diet = params[:profile][:diet]
    @intolerances = params[:profile][:intolerances]
    @allergies = params[:profile][:ingredients]

    @combination = @diet + @intolerances + @allergies

    @profile = Profile.create(school: @school)

    AllergyProfile.create(profile: @profile, ingredient: @diet)

    @intolerances.each do |intolerance|
      AllergyProfile.create(profile: @profile, ingredient: intolerance)
    end

    @allergies.each do |allergy|
      AllergyProfile.create(profile: @profile, ingredient: allergy)
    end
  end
end
