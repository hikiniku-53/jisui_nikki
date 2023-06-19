class CreateCuttingBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :cutting_boards do |t|

      t.timestamps
    end
  end
end
