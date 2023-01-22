class WeekMenu < ApplicationRecord
  belongs_to :profile
  has_many :day_menus, dependent: :destroy
  has_many :menu_dishes, through: :day_menus, dependent: :destroy
  has_many :dishes, through: :menu_dishes
  validates :date, presence: true, uniqueness: { scope: %i[profile] }

  def return_status
    self.status == true ? "Approved" : "Pending"
  end

  def next
    @school = self.profile.school
    WeekMenu.joins(:profile).where(profiles: { school: @school, active: true }).where("week_menus.id > ?", id).order(id: :asc).limit(1).first
  end

  def prev
    @school = self.profile.school
    WeekMenu.joins(:profile).where(profiles: { school: @school, active: true }).where("week_menus.id < ?", id).order(id: :asc).limit(1).first
  end
end
