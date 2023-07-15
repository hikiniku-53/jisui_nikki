class CreatePlateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :plate_foods do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :food_id, foreign_key: true
      t.references :recipe_id, foreign_key: true
      t.integer    :price
      t.integer    :energy, null: false
      t.integer    :protein
      t.integer    :fat
      t.integer    :carb
      t.integer    :salt_equivalent
      t.float      :amount, null: false

      t.timestamps
    end
  end
end
