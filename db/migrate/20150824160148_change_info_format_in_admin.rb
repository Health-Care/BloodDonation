class ChangeInfoFormatInAdmin < ActiveRecord::Migration
  def change
  	change_column :users, :lastdonation, :date
  end
end
