class AddScoreToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :score, :integer
  end
end
