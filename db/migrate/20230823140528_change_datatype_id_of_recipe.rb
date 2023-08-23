class ChangeDatatypeIdOfRecipe < ActiveRecord::Migration[6.1]
  def change
    change_column :recipes, :id, :bigint
  end
end
