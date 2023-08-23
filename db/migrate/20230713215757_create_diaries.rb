class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.references :customer, type: :bigint, null: false, foreign_key: true
      t.date       :date, null: false
      t.integer    :body_weight
      t.text       :body

      t.timestamps
    end
    add_index :diaries, [:customer_id, :date]
  end
end
