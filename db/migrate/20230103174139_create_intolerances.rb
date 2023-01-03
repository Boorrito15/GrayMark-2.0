class CreateIntolerances < ActiveRecord::Migration[7.0]
  def change
    create_table :intolerances do |t|
      t.string :name

      t.timestamps
    end
  end
end
