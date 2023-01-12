class AddActiveToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :active, :boolean
  end
end
