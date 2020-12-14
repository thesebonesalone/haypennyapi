class AddPositivityToOpinions < ActiveRecord::Migration[6.0]
  def change
    add_column :opinions, :positivity, :integer
  end
end
