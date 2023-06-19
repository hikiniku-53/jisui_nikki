class CreateCommentGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_genres do |t|

      t.timestamps
    end
  end
end
