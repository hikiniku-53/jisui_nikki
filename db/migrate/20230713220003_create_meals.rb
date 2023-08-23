class CreateMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :meals do |t|
      t.references :customer, type: :bigint, null: false, foreign_key: true
      t.references :food, type: :bigint, foreign_key: true
      t.references :recipe, type: :bigint, foreign_key: true
      t.date       :date, null: false
      t.integer    :time, null: false
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

