class School < ApplicationRecord
  belongs_to :user
  has_many :profiles, dependent: :destroy
  has_many :week_menus, through: :profiles
  has_many :day_menus, through: :week_menus
  has_one_attached :photo
  validates :name, presence: true, uniqueness: { scope: :town }
  validates :postcode, presence: true, uniqueness: true
  validates :town, presence: true
  validates :address, presence: true, uniqueness: true
end
