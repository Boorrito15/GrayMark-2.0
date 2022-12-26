class MenuDish < ApplicationRecord
  belongs_to :day_menu
  belongs_to :dish
end
