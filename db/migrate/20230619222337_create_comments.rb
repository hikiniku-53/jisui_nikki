class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.bigint :customer_id, null: false
      t.bigint :comment_genre_id, null: false
      t.bigint :food_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
