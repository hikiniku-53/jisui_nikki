class ChangeDatatypeRecipeIdOfRecipeTag < ActiveRecord::Migration[6.1]
  def change
    change_column :recipe_tags, :recipe_id, :bigint
  end
end
