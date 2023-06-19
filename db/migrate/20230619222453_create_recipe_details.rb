class CreateRecipeDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_details do |t|

      t.timestamps
    end
  end
end
