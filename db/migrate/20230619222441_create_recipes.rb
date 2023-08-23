class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|

      t.bigint :customer_id, null: false
      t.string :name, null: false
      t.text :process
      t.text :comment
      t.boolean :is_published, null: false, default: "FALSE"

      t.timestamps
    end
  end
end
