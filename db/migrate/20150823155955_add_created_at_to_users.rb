require 'date'

class AddCreatedAtToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :created_at, :date, :null => false, :default => Time.now.strftime("%Y-%m-%d")
  	change_column :requests, :created_at, :date, :null => false, :default => Time.now.strftime("%Y-%m-%d")
  end
end
