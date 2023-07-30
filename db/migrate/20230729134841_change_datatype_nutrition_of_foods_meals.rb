class ChangeDatatypeNutritionOfFoodsMeals < ActiveRecord::Migration[6.1]
  def change
    change_column :meals, :energy, :float
    change_column :meals, :protein, :float
    change_column :meals, :fat, :float
    change_column :meals, :carb, :float
    change_column :meals, :salt_equivalent, :float
  end
end
