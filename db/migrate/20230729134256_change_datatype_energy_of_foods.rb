class ChangeDatatypeEnergyOfFoods < ActiveRecord::Migration[6.1]
  def change
    change_column :foods, :protein, :float
  end
end
