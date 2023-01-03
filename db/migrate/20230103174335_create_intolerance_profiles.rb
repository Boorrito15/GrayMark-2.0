class CreateIntoleranceProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :intolerance_profiles do |t|
      t.references :intolerance, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
