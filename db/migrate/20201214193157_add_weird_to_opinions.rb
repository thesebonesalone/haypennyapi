class AddWeirdToOpinions < ActiveRecord::Migration[6.0]
  def change
    add_column :opinions, :weird, :integer
  end
end
