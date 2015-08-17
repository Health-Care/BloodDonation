class CreateActiveRequests < ActiveRecord::Migration
  def change
    create_table :active_requests do |t|
      t.string :donor_id
      t.string :request_id

      t.timestamps null: false
    end
  end
end
