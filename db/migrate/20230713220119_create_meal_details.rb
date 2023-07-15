class CreateMealDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :meal_details do |t|
      t.integer :meal_id, null: false
      t.integer :food_id
      t.integer :recipe_id
      t.integer :price

      t.float   :amount, null: false

      t.timestamps
    end
  end
end
