class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|

      t.integer :food_genre_id, null: false
      t.string :food_name, null: false
      t.integer :energy, null: false
      t.integer :protein
      t.integer :fat
      t.integer :carb
      t.integer :salt_equivalent

      t.timestamps
    end
  end
end
