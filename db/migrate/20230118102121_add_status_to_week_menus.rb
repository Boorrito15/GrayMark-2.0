class AddStatusToWeekMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :week_menus, :status, :boolean
  end
end
