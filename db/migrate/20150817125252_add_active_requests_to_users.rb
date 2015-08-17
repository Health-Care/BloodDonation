class AddActiveRequestsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :num_of_active_requests, :integer
  	add_column :requests, :num_of_donors, :integer
  end
end
