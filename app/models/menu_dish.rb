class MenuDish < ApplicationRecord
  belongs_to :DayMenu
  belongs_to :dish
end
