class AddHideaccountToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :hide_account, :boolean, :default => false
  end
end
