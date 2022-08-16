class RemoveColumsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :place_id, :string
  end
end
