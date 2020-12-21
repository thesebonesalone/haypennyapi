class CreateCommentVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_votes do |t|
      t.integer :value
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
