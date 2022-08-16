class AddColumsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :place_id, :string
  end
end
