class AllergyProfile < ApplicationRecord
  belongs_to :profile
  belongs_to :ingredient
end
