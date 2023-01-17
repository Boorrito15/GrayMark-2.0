class Intolerance < ApplicationRecord
  has_many :intolerance_profiles, dependent: :destroy
  validates :name, presence: true
end
