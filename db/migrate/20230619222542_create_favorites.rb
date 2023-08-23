class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :customer, type: :bigint, null: false, foreign_key: true
      t.references :recipe, type: :bigint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
