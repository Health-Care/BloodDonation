class AddBirthdayToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :age
  	add_column :users, :birth_date, :date
  end
end
