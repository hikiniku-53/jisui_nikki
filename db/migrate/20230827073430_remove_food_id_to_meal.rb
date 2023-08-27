class RemoveFoodIdToMeal < ActiveRecord::Migration[6.1]
  def change
    remove_column :meals, :food_id, :integer
    remove_column :meals, :recipe_id, :integer
  end
end
