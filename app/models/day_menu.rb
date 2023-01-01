class DayMenu < ApplicationRecord
  belongs_to :week_menu
  has_many :menu_dishes
  has_many :dishes, through: :menu_dishes
  validates :date, presence: true
  validates :date, presence: true, uniqueness: { scope: %i[week_menu] }

  def self.cuisine
    @cuisines = ["African", "American", "British", "Cajun", "Caribbean", "Chinese", "Eastern European", "European", "French", "German", "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish", "Korean", "Latin American", "Mediterranean", "Mexican", "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"]
  end
end
