class ChangeDatatypeAmountOfCuttingBoardFood < ActiveRecord::Migration[6.1]
  def change
    change_column :cutting_board_foods, :amount, :float
  end
end
