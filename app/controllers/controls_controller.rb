class ControlsController < ApplicationController
  before_action :authenticate_logging_in
  before_action :authenticate_superadmin_logging_in, only: [:newadmin, :create_new_admin,:admins,:delete,:update,:edit,:edit_admin]

  def index
    session[:return_to] = controls_path
    system = Admin.new 
    @users_number = system.getNumberofUsers 
    @admins_number = system.getNumberofAdmins
    @requests_number = system.getNumberofAllRequests
    @active_requests_number  = system.getNumberofActiveRequests
    @expired_requests_number  = system.getNumberofExpiredRequests
  end 
  
  def newadmin
    @admin = Admin.new  
  end 

  def create_new_admin
    @admin = Admin.new  
    @admin.email = params[:controls][:email]
    @admin.password = params[:controls][:password]
    password_confirmation = params[:controls][:password_confirmation]

    if password_confirmation != @admin.password
      redirect_to newadmin_controls_path, notice: "Incorrect passwords, try again"
    elsif @admin.exist?
      redirect_to newadmin_controls_path, notice: "This email already signed to anther admin"    
    else
      if @admin.save 
        redirect_to root_url, notice: 'successfully created a new admin'
      else
        redirect_to newadmin_controls_path, notice: "Something went wrong, try again"
      end
    end
  end 

  def admins
    @admins = Admin.all.offset(1)
  end
  
  def delete
    @admin = Admin.new  
    @admin.id = params[:controls][:id] 

    if @admin.delete
      redirect_to admins_controls_path, notice: "successfully Deleted this admin!"
    else
      redirect_to admins_controls_path, notice: "Something error, try again"  
    end
  end

  def update
    @admin = Admin.new  
    @admin.id = params[:controls][:id]
    @admin.email = params[:controls][:email]
    @admin.password = params[:controls][:password]

    if @admin.password == nil || @admin.email == nil
      redirect_to admins_controls_path, notice: "Please insert email and password fields"
    elsif @admin.update
      redirect_to admins_controls_path, notice: "successfully updated this admin"
    end
  end

  def edit_admin
    @admin = Admin.new  
  end

  def edit
    @admin = Admin.new  
    @admin.id = 1
    @admin.email = params[:controls][:email]
    @admin.password = params[:controls][:password]
    password_confirmation = params[:controls][:password_confirmation]

    if password_confirmation != @admin.password
      redirect_to edit_admin_controls_path, notice: "Incorrect passwords, try again"
    elsif email_exist(@admin.email)
      redirect_to edit_admin_controls_path, notice: "This email already signed to anther admin"    
    elsif @admin.update
      redirect_to controls_path, notice: "successfully updated this admin"
    end
  end

  def email_exist(email)
    @admins = Admin.all.offset(1)
    @admins.each do |admin|
      if admin.email == email
          return true
      end
    end
    false    
  end

  # history of donors  
  def donorshistory
    session[:return_to] = donorshistory_controls_path
    @users = Admin.today_registeredUsers   
  end
  
  def search_registerd_users
    date = params[:controls][:date]
    session[:date] = date
    redirect_to historyregisteredDonors_controls_path
  end

  def historyregisteredDonors
    session[:return_to] = historyregisteredDonors_controls_path
    date= session[:date]
    @users = Admin.last_registeredUsers(date)
  end

  def showdonor
    @user = User.find(session[:user_id])
  end

  def donor
    session[:user_id] = params[:controls][:user_id]
    redirect_to showdonor_controls_path
  end

  def update_donor
    @user = User.find(session[:user_id])
    @user.update_attribute(:name, params[:controls][:name])
    @user.update_attribute(:email, params[:controls][:email])
    @user.update_attribute(:phone, params[:controls][:phone])
    @user.update_attribute(:gender, params[:controls][:gender])
    @user.update_attribute(:nationalid, params[:controls][:nationalid])
    @user.update_attribute(:birth_date, params[:controls][:birth_date])
    @user.update_attribute(:location_name, params[:controls][:location_name])
    @user.update_attribute(:location_lat, params[:controls][:location_lat])
    @user.update_attribute(:location_lng, params[:controls][:location_lng])
    @user.update_attribute(:blood_type, params[:controls][:blood_type])
    @user.update_attribute(:password, params[:controls][:password])
    @user.update_attribute(:can_donate, params[:controls][:can_donate])
    @user.update_attribute(:savedpeople, params[:controls][:savedpeople])
    @user.update_attribute(:lastdonation, params[:controls][:lastdonation])
    @user.update_attribute(:num_of_active_requests, params[:controls][:num_of_active_requests])
    redirect_to showdonor_controls_path, notice: "successfully updated this user"
  end

  def deletedonor
    user_id = params[:controls][:user_id]
    Admin.deleteDonor(user_id)
    redirect_to session.delete(:return_to), :notice => "successfully Deleted this donor!"
  end

  ##########################################
  # history of cases 
  def caseshistory
    session[:return_to] = caseshistory_controls_path
    @requests = Admin.today_submittedRequests 
  end

  def search_registerd_cases
    date = params[:controls][:date]
    session[:date] = date
    redirect_to historyregisteredCases_controls_path
  end

  def historyregisteredCases
    session[:return_to] = historyregisteredCases_controls_path
    date= session[:date]
    @requests = Admin.last_registeredCases(date)
  end

  def showcase
    session[:return_to] = showcase_controls_path
    if session[:return] == deletecase_controls_path
      session.delete(:return)
      redirect_to controls_path
    else
      @request = Request.find(session[:request_id])
    end
  end

  def case
    session[:request_id] = params[:controls][:request_id]
    redirect_to showcase_controls_path
  end

  def chartsreports
    @userspermonth = Admin.getUsersChartPerMonth
    @requestspermonth = Admin.getRequestsChartPerMonth
    @usersperday = Admin.getUsersChartPerDay
    @requestsperday = Admin.getRequestsChartPerDay
  end
  
  def update_case
    @user = Request.find(session[:request_id])
    @user.update_attribute(:contact_name, params[:controls][:contact_name])
    @user.update_attribute(:contact_email, params[:controls][:contact_email])
    @user.update_attribute(:contact_phone, params[:controls][:contact_phone]) 
    @user.update_attribute(:contact_nationalid, params[:controls][:contact_nationalid])
    @user.update_attribute(:blood_type, params[:controls][:blood_type])
    @user.update_attribute(:bloodbag, params[:controls][:bloodbag])
    @user.update_attribute(:patient_name, params[:controls][:patient_name])
    @user.update_attribute(:expiredate, params[:controls][:expiredate])
    @user.update_attribute(:hospital_location_lng, params[:controls][:hospital_location_lat])
    @user.update_attribute(:hospital_location_lat, params[:controls][:hospital_location_lng])
    @user.update_attribute(:hospital_location, params[:controls][:hospital_location])
    @user.update_attribute(:hospital_name, params[:controls][:hospital_name])
    redirect_to showcase_controls_path, notice: "successfully updated this case"
  end

  def deletecase
    request_id = params[:controls][:request_id] 
    session[:return] = deletecase_controls_path
    Admin.deleteCase(request_id)
    redirect_to session.delete(:return_to), :notice => 'Successfully you delete this case'
  end

  # search about donor
  def searchdonor
    search_tag = params[:controls][:search_tag]
    @user = User.new
    if search_tag.numeric?
       @user_id = Admin.getDonorByMobileNumber(search_tag)
    elsif search_tag.email?
       @user_id = Admin.getDonorByMobileEmail(search_tag)
    else
       @user_id = nil
    end

    if @user_id
      session[:user_id] = @user_id
      redirect_to showdonor_controls_path
    else
      redirect_to controls_path, :notice => 'There is no Donors with this email or mobile number'
    end
  end

  # delete cases from , to
  def deletecasesfromto
    from = params[:controls][:from]
    to = params[:controls][:to]
    Admin.deleteCasesFromTO(from,to)
    redirect_to controls_path, :notice => 'Successfully deleted those cases'
  end

  #show active requests with donors
  def activerequests
    session[:return_to] = activerequests_controls_path
    @requests = Admin.getActiveRequests
  end

  #show active requests without donors
  def requests
    session[:return_to] = requests_controls_path
    @requests = Admin.getRequests
  end

  def request_donors
    session[:request_id] = params[:controls][:request_id]
    redirect_to requestdonors_controls_path
  end

  #show expired requests
  def expiredrequests
    session[:return_to] = expiredrequests_controls_path
    @requests = Admin.getExpiredRequests
  end

  #show request donors
  def requestdonors
    session[:return_to] = requestdonors_controls_path
    request_id = session[:request_id]
    @users = Admin.getRequestsDonors(request_id)
  end

  #confirm donation process
  def confirm_donation
    user_id = params[:controls][:user_id]
    request_id = session[:request_id]
    Admin.confirmDonationProcess(user_id,request_id)
    redirect_to requestdonors_controls_path, :notice => 'Successfully confirm this donation'
  end

  #confirm donation process
  def cancel_donation
    user_id = params[:controls][:user_id]
    request_id = session[:request_id]
    Admin.cancelDonationProcess(user_id,request_id)
    redirect_to requestdonors_controls_path, :notice => 'Successfully cancel this donation'
  end

  def expire
    request_id = params[:controls][:request_id]
    Request.find(request_id).update_attribute(:expiredate,'2010-10-10')
    
    redirect_to session.delete(:return_to) , :notice => 'Successfully you mark this case as expired'
  end

  def create_new_donor
    @user = User.new
    @user.name = params[:controls][:name]
    @user.email = params[:controls][:email]
    @user.phone = params[:controls][:phone]
    @user.nationalid = params[:controls][:nationalid]
    @user.blood_type = params[:controls][:blood_type]
    @user.location_name = params[:controls][:location_name]
    @user.location_lat = params[:controls][:location_lat]
    @user.location_lng = params[:controls][:location_lng]
    @user.gender = params[:controls][:gender]
    @user.birth_date = params[:controls][:birth_date]
    @user.created_at = params[:controls][:created_at]
    @user.password = params[:controls][:password]
    @user.num_of_active_requests = params[:controls][:num_of_active_requests]
    password_confirmation = params[:controls][:password_confirmation]

    if !User.where(:email => @user.email).blank?
      redirect_to newdonor_controls_path, :notice => 'Email already used by another donor'
    elsif !User.where(:phone => @user.phone).blank?
      redirect_to newdonor_controls_path, :notice => 'Phone number already used by another donor'
    elsif !User.where(:nationalid => @user.nationalid).blank?
      redirect_to newdonor_controls_path, :notice => 'National id already used by another donor'
    elsif password_confirmation != @user.password
      redirect_to newdonor_controls_path, :notice => 'Please make sure that two passwords matches each other'
    else
      @user.save
      redirect_to controls_path, :notice => 'Successfully created a new donor'  
    end  
  end

  def newdonor
    session[:return_to] = newdonor_controls_path
    @user = User.new
  end

  def sendemail
    textmsg = params[:controls][:textmsg]
    user_email = params[:controls][:user_email]
    subject = params[:controls][:subject]

    users = []
    users << user_email
    users << current_admin.email

    Thread.new do
      UserMailer.new_custom_email(users, textmsg, subject).deliver_now
    end

    redirect_to session.delete(:return_to)  , notice: "Message sent successfully"   
  end 

  private
    #authenticate admin
    def authenticate_logging_in
      if current_admin === nil
        redirect_to new_admin_session_path , notice: "You must login first!"       
      end
    end

    #authenticate super admin
    def authenticate_superadmin_logging_in
      if !current_admin.superadmin?
        redirect_to controls_path       
      end
    end

    def set_user 
      @admin = Admin.find( Admin.decrypt(params[:id]) )
    end 
end

class String

  def numeric?
    Float(self) != nil rescue false
  end

  def email?
    if self.match(/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/)
      true  
    else
      false
    end
  end

end