class StopRecevingEmails < ActiveRecord::Migration
  def change
  	add_column :users, :stop_getting_email, :boolean, :default => false
  end
end
