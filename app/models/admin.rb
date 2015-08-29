class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
 

  def getNumberofUsers
  	User.count 
  end

  def getNumberofActiveRequests
  	Request.select("*").where('expiredate >= ? ' , Date.today).count 
  end

  def getNumberofAllRequests
  	Request.count 
  end

  def getNumberofExpiredRequests
  	Request.select("*").where('expiredate <? ' , Date.today).count 
  end

  def getNumberofAdmins
  	Admin.count 
  end

  def self.today_registeredUsers
    @users = User.where("created_at = ?", Time.now.strftime("%Y-%m-%d"))
  end

  def self.today_submittedRequests
    @requests = Request.where("created_at = ?", Time.now.strftime("%Y-%m-%d"))
  end

  def self.last_registeredUsers(date)
    @users = User.where("created_at = ?", date)
  end

  def self.last_registeredCases(date)
    Request.where("created_at = ?", date)
  end

  def delete
  	Admin.find(self.id).destroy
  end

  def self.deleteDonor(donor_id)
    User.find(donor_id).destroy
  end

  def self.updateDonorsOfDeletedCase(request_id)
    @active_requests = ActiveRequest.select("*").where('request_id = ? ' , request_id.to_s)
    @active_requests.each do |active_request| 
       if User.exists?(active_request.donor_id)
          @user = User.find( active_request.donor_id )
          @user.update_attribute(:num_of_active_requests,@user.num_of_active_requests - 1)
       end
    end 

    ActiveRequest.where('request_id = ? ' , request_id.to_s).destroy_all
  end

  def self.deleteCase(request_id)
    Admin.updateDonorsOfDeletedCase(request_id)
    Request.find(request_id).destroy
  end

  def self.deleteCasesFromTO(from,to)
    Request.where('created_at >= ? and created_at <= ?' ,from,to).destroy_all
  end

  def update
  	Admin.find(self.id).update_attribute(:email , self.email)
  	Admin.find(self.id).update_attribute(:password , self.password)
  end
  
  def self.getDonorByMobileNumber(mobile_number)
    @user = User.select("*").where('phone = ? ' , mobile_number.to_s).first
    if @user == nil
      nil
    else
      @user.id
    end
  end

  def self.getDonorByEmail(email)
    @user = User.select("*").where('email = ? ' , email.to_s).first
    if @user == nil
      nil
    else
      @user.id
    end
  end
  
  def self.getCasesByMobileNumber(mobile_number)
    Request.select("*").where('contact_phone = ? ' , mobile_number.to_s)
  end

  def self.getCasesByEmail(email)
    Request.select("*").where('contact_email = ? ' , email.to_s)
  end 

  def self.getCasesByBloodType(bloodtype)
    Request.select("*").where('blood_type = ? ' , bloodtype.to_s)
  end 

  def self.getActiveRequests
    Request.select("*").where('expiredate >= ? and num_of_donors > ?' , Date.today ,0).order('created_at DESC')
  end
  
  def self.getRequests
    Request.select("*").where('expiredate >= ? and num_of_donors IS ?' , Date.today,0).order('created_at DESC')
  end

  def self.getExpiredRequests
    Request.select("*").where('expiredate < ?' , Date.today).order('created_at DESC')
  end

  def self.getRequestsDonors(request_id)
    @active_requests = ActiveRequest.select("*").where('request_id = ? ' , request_id.to_s).order('created_at DESC') 

    @users = []

    @active_requests.each do |active_requests| 
      if User.exists?(active_requests.donor_id)
        @users << User.find( active_requests.donor_id )
      end
    end 

    @users
  end

  def self.confirmDonationProcess(user_id,request_id)
    @user = User.find(user_id)
    @user.update_attribute(:lastdonation , Time.now.strftime("%Y-%m-%d") )
    @user.update_attribute(:savedpeople , @user.savedpeople + 1)
    @user.update_attribute(:num_of_active_requests , @user.num_of_active_requests - 1)
    ActiveRequest.select("*").where('donor_id = ? and request_id = ?' , user_id , request_id).destroy_all
    @request = Request.find(request_id)
    @request.update_attribute(:num_of_donors,@request.num_of_donors - 1)
  end

  def self.cancelDonationProcess(user_id,request_id)
    ActiveRequest.select("*").where('donor_id = ? and request_id = ?' , user_id , request_id).destroy_all
    @request = Request.find(request_id)
    @request.update_attribute(:num_of_donors,@request.num_of_donors - 1)
    @user = User.find(user_id)
    @user.update_attribute(:num_of_active_requests , @user.num_of_active_requests - 1 )
  end

  def self.getUsersChartPerMonth
    arr = [0,0,0,0,0,0,0,0,0,0,0,0]
    for i in 0..11
      arr[i] = User.where("strftime('%m', created_at) + 0 = ? and strftime('%Y', created_at) + 0 = ?", i + 1 , Time.now.strftime("%Y").to_i).count
    end
    arr
  end

  def self.getRequestsChartPerMonth
    arr = [0,0,0,0,0,0,0,0,0,0,0,0]
    for i in 0..11
      arr[i] = Request.where("strftime('%m', created_at) + 0 = ? and strftime('%Y', created_at) + 0 = ?", i + 1 , Time.now.strftime("%Y").to_i).count
    end
    arr
  end

  def self.getUsersChartPerDay
    arr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    for i in 0..30
      arr[i] = User.where("strftime('%d', created_at) + 0 = ? and  strftime('%m', created_at) + 0 = ? and strftime('%Y', created_at) + 0 = ?", i + 1 ,Time.now.strftime("%m").to_i, Time.now.strftime("%Y").to_i).count
    end
    arr
  end

  def self.getRequestsChartPerDay
    arr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    for i in 0..30
      arr[i] = Request.where("strftime('%d', created_at) + 0 = ? and  strftime('%m', created_at) + 0 = ? and strftime('%Y', created_at) + 0 = ?", i + 1 ,Time.now.strftime("%m").to_i, Time.now.strftime("%Y").to_i).count
    end
    arr
  end

  def self.valid_email_param(user,user_email)  
    if User.where('id != ? and email = ?',user.id,user_email).blank?
     return "ok"
    else
     return "Email already used by another donor"
    end  
  end

  def self.valid_phone_param(user,user_phone) 
    if User.where('id != ? and phone = ?',user.id,user_phone).blank?
     return "ok"
    else
     return "Phone already used by another donor"
    end  
  end

  def self.valid_nationalid_param(user, user_nationalid) 
    if User.where('id != ? and nationalid = ?',user.id,user_nationalid).blank?
     return "ok"
    else
     return "nationalid already used by another donor"
    end  
  end

  def exist?
  	if Admin.where(:email => self.email).blank?
  	  false
  	else
  	  true
  	end    	
  end

end
