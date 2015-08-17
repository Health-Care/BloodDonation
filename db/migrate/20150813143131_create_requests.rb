class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :nationalid
      t.string :patientname
      t.string :faselty
      t.date :expiredate
      t.integer :bloodbag
      t.string :hospitalname
      t.string :hospitalphone
      t.string :hospitaladdress

      t.timestamps null: false
    end
  end
end
