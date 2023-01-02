class CreateSpoonaculars < ActiveRecord::Migration[7.0]
  def change
    create_table :spoonaculars do |t|

      t.timestamps
    end
  end
end
