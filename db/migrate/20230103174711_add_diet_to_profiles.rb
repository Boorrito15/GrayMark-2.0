class AddDietToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_reference :profiles, :diet, null: true, foreign_key: true
  end
end
