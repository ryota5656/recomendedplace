class AddColumsToCompletes < ActiveRecord::Migration[5.2]
  def change
    add_column :completes, :rate, :float
    add_column :completes, :comment, :string
  end
end
