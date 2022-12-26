class CreateAllergyProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :allergy_profiles do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
