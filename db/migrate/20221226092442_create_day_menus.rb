class CreateDayMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :day_menus do |t|
      t.date :date
      t.references :week_menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
