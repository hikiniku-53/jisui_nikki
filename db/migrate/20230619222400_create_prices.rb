class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|

      t.references :customer, type: :bigint, null: false, foreign_key: true
      t.references :food, type: :bigint, null: false, foreign_key: true
      t.integer :food_price, null: false

      t.timestamps
    end
  end
end
