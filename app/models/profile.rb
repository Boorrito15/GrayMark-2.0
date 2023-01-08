class Profile < ApplicationRecord
  belongs_to :school
  belongs_to :diet
  has_many :intolerance_profiles
  has_many :intolerances, through: :intolerance_profiles
  has_many :allergy_profiles
  has_many :ingredients, through: :allergy_profiles
  has_many :week_menus
  has_many :day_menus, through: :week_menus
end
