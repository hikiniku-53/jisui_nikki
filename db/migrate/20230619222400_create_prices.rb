class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|

      t.integer :customer_id, null: false
      t.integer :food_id, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
