class AddNameProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: true
    add_column :users, :profile, :string, null: true
    add_column :users, :image, :string, null: true
  end
end
