class ChangeDatatypeBodyWeightOfDiary < ActiveRecord::Migration[6.1]
  def change
    change_column :diaries, :body_weight, :float
  end
end
