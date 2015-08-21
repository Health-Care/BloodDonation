require 'Obfuscate'

class Request < ActiveRecord::Base

  include Obfuscate

  
  validates_presence_of :contact_name, :message=> "Must enter your name!"
  
  validates_presence_of :contact_phone, :message=> "Must enter your Mobile number!"
  validates_length_of :contact_phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :contact_phone, :message=> "Must enter mobile number in numerical form only!"
 
  validates_presence_of :contact_email, :message=> "Must enter your contact email!"
  
  validates_presence_of :contact_nationalid, :message=> "Must enter your ID!"
  validates_length_of :contact_nationalid, minimum: 14, maximum: 14, :message=> "National id must be of length 14.."
  validates_numericality_of :contact_nationalid, :message=> "Must enter national id in numerical form only!"
 
  validates_presence_of :patient_name, :message=> "Must enter patient name!"
  validates_presence_of :hospital_name, :message=> "Must enter hospital name!"
  validates_presence_of :bloodbag, :message=> "Must enter number of bloodbag!"
  validates_presence_of :blood_type, :message=> "Must enter the blood type"
  validates_presence_of :expiredate, :message=> "Must enter the expire date"

  def self.my_active_donors(request) 
    @active_requests = ActiveRequest.select("*").where('request_id = ? ' , request.id.to_s).order('created_at DESC') 

    @users = []

    @active_requests.each do |active_requests| 
      if User.exists?(active_requests.donor_id)
        @users << User.find( active_requests.donor_id )
      end
    end 

    request.update_attribute(:num_of_donors, @users.size)
    @users
  end
  
  def self.get_unexpired_requests
    @requests = Request.select("*").where('expiredate >= ? ' , Date.today).order('created_at DESC') 
  end 

  def all_users_with_blood_type(blood_type)
    @users = User.select("*").where(:blood_type => blood_type) 
  end  
  
  def update_num_of_donors(request,current_user)
     if request.num_of_donors == nil && Request.exists?(request.id)
       Request.find( request.id ).update_attribute(:num_of_donors, 1)
     else
       Request.find( request.id ).update_attribute(:num_of_donors, request.num_of_donors + 1)
     end   

     if current_user.num_of_active_requests == nil 
       current_user.update_attribute(:num_of_active_requests, 1)
     else
       current_user.update_attribute(:num_of_active_requests, current_user.num_of_active_requests + 1)
     end  
  end

  def to_param
    encrypt id
  end
end
