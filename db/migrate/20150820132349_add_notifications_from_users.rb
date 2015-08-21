class AddNotificationsFromUsers < ActiveRecord::Migration
  def change
  	add_column :users, :notifications, :integer, :default => 0
  	add_column :users, :can_donate, :boolean, :default => true
  end
end
