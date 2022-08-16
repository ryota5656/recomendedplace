class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :user_id
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.float :price_level
      t.float :rating

      t.timestamps
    end
  end
end
