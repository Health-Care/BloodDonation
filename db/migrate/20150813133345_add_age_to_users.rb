class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :decimal
    add_column :users, :phone, :string
    add_column :users, :nationalid, :string

    add_column :users, :address, :string
    add_column :users, :faselty, :string
    add_column :users, :gender, :string
    add_column :users, :lastdonation, :timestamp
    add_column :users, :savedpeople, :decimal
    add_column :users, :notifications, :decimal
  end
end 