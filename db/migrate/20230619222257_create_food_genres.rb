class CreateFoodGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :food_genres do |t|

      t.string :food_genre_name, null: false

      t.timestamps
    end
  end
end
