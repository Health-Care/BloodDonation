class AddLocationToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :address
    add_column :users, :location_lat, :float
    add_column :users, :location_lng, :float
    add_column :users, :location_name, :string
  end
end
