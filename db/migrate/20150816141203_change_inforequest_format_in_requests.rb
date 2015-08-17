class ChangeInforequestFormatInRequests < ActiveRecord::Migration
    def change
   remove_column :users, :hospital_location_lng 
   add_column :requests, :hospital_location_lng, :float
  end

end
