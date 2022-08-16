class AddColumsToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :place_id, :string
  end
end
