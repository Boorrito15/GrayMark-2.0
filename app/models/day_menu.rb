class DayMenu < ApplicationRecord
  belongs_to :WeekMenu
  has_many :menu_dishes
  has_many :dishes through: :menu_dishes
end
