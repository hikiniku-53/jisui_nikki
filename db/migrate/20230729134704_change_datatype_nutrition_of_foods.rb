class ChangeDatatypeNutritionOfFoods < ActiveRecord::Migration[6.1]
  def change
    change_column :foods, :energy, :float
    change_column :foods, :fat, :float
    change_column :foods, :carb, :float
    change_column :foods, :salt_equivalent, :float

  end
end
