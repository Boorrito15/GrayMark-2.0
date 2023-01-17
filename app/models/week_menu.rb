class WeekMenu < ApplicationRecord
  belongs_to :profile
  has_many :day_menus, dependent: :destroy
  has_many :menu_dishes, through: :day_menus, dependent: :destroy
  has_many :dishes, through: :menu_dishes
  validates :date, presence: true, uniqueness: { scope: %i[profile] }
end
