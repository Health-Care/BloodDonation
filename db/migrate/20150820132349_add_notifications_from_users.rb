class AddNotificationsFromUsers < ActiveRecord::Migration
  def change 
  	add_column :users, :can_donate, :boolean, :default => true
  end
end
