class AllergyProfile < ApplicationRecord
  belongs_to :ingredient
  belongs_to :profile
end
