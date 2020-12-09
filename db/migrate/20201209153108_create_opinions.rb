class CreateOpinions < ActiveRecord::Migration[6.0]
  def change
    create_table :opinions do |t|
      t.string :content
      t.integer :parent_id
      t.integer :topic_id
      t.integer :user_id

      t.timestamps
    end
  end
end
