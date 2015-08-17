class AddPauseToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :pause, :boolean, :default => false
  end
end
