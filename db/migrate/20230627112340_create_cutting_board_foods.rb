class CreateCuttingBoardFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :cutting_board_foods do |t|

      t.bigint :customer_id, null: false
      t.bigint :food_id, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
