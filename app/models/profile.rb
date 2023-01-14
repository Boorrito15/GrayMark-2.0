class Profile < ApplicationRecord
  belongs_to :school
  belongs_to :diet, optional: true
  has_many :intolerance_profiles, dependent: :destroy
  has_many :intolerances, through: :intolerance_profiles
  has_many :allergy_profiles, dependent: :destroy
  has_many :ingredients, through: :allergy_profiles
  has_many :week_menus, dependent: :destroy
  has_many :day_menus, through: :week_menus
end
