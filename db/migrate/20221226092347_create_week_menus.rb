class CreateWeekMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :week_menus do |t|
      t.date :date
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
