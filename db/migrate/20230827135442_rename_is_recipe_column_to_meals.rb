class RenameIsRecipeColumnToMeals < ActiveRecord::Migration[6.1]
  def change
    rename_column :meals, :IsRecipe, :is_recipe
  end
end
