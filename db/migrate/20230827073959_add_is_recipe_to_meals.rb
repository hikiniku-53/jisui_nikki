class AddIsRecipeToMeals < ActiveRecord::Migration[6.1]
  def change
    add_column :meals, :IsRecipe, :boolean
  end
end
