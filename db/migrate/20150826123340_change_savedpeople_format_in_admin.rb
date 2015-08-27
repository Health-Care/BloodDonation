class ChangeSavedpeopleFormatInAdmin < ActiveRecord::Migration
  def change
  	change_column :users, :savedpeople, :integer
  end
end
