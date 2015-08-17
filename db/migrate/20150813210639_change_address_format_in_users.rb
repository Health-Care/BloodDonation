class ChangeAddressFormatInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :savedpeople, :integer, :default => 0
  	change_column :users, :notifications, :integer, :default => 0 

  end
end
