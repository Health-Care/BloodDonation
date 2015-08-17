class ChangeInfoFormatInRequests < ActiveRecord::Migration
  
  def change
   remove_column :requests, :hospitalphone
   rename_column :requests, :name, :contact_name
   rename_column :requests, :email, :contact_email
   rename_column :requests, :nationalid, :contact_nationalid
   rename_column :requests, :phone, :contact_phone

   rename_column :requests, :patientname, :patient_name
   rename_column :requests, :hospitalname, :hospital_name
   rename_column :requests, :hospitaladdress, :hospital_location

   rename_column :requests, :faselty, :blood_type
   rename_column :users, :faselty, :blood_type
   
   add_column :requests, :hospital_location_lat, :float
   add_column :users, :hospital_location_lng, :float
  end

end
