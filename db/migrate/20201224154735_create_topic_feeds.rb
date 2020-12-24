class CreateTopicFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_feeds do |t|
      t.integer :topic_id

      t.timestamps
    end
  end
end
