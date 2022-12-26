class SchoolsController < ApplicationController
  def index
    @schools = School.all.where(user: current_user)
  end
end
