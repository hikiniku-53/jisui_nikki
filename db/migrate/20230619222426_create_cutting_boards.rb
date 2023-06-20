class CreateCuttingBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :cutting_boards do |t|

      t.integer :customer_id, null: false
      t.integer :food_id, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
