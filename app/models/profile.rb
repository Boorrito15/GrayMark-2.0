class Profile < ApplicationRecord
  belongs_to :school
  has_many :allergy_profiles
  # has many :ingredients, through: :allergy_profiles
  has_many :week_menus
  # has_many :day_menus, through: :week_menus
end
