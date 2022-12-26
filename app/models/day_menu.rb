class DayMenu < ApplicationRecord
  belongs_to :week_menu
  has_many :menu_dishes
  has_many :dishes, through: :menu_dishes
  validates :date, presence: true
  validates :date, presence: true, uniqueness: { scope: %i[week_menu] }
end
