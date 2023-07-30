class ChangeDatatypeAmountOfCuttingBoardFoods < ActiveRecord::Migration[6.1]
  def change
    change_column :recipe_details, :amount, :float
  end
end
