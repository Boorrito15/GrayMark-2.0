class School < ApplicationRecord
  belongs_to :user
  has_many :profiles
  has_many :week_menus, through: :profiles
  has_many :day_menus, through: :week_menus
end
