class ChangeNotificationsFormatInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :savedpeople, :integer
  	change_column :users, :notifications, :integer 
  end
end 