class WeekMenu < ApplicationRecord
  belongs_to :profile
  has_many :day_menus
  has_many :menu_dishes, through :day_menus
  has_many :dishes, through :menu_dishes
end
