class CreateRecipeDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_details do |t|

      t.integer :recipe_id, null: false
      t.integer :food_id, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
