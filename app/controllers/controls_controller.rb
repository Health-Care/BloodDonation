class ControlsController < ApplicationController
  before_action :authenticate_logging_in
  before_action :authenticate_superadmin_logging_in, only: [:newadmin, :admins, :edit_admin]

  def index
    session[:return_to] = controls_path
    system = Admin.new 
    @users_number = system.getNumberofUsers 
    @admins_number = system.getNumberofAdmins
    @requests_number = system.getNumberofAllRequests
    @active_requests_number  = system.getNumberofActiveRequests
    @expired_requests_number  = system.getNumberofExpiredRequests
  end 

  def admins
    @admins = Admin.all.offset(1)
  end 
  
  # history of donors  
  def donorshistory
    session[:return_to] = donorshistory_controls_path
    @users = Admin.today_registeredUsers   
  end
  
  def historyregisteredDonors
    session[:return_to] = historyregisteredDonors_controls_path
    date= session[:date]
    @users = Admin.last_registeredUsers(date)
  end

  def showdonor
    @user = User.find(session[:user_id])
  end

  def showcases
    session[:return_to] = showcases_controls_path
    search_tag = session[:search_tag]
    @requests = nil
    if search_tag.numeric?
       @requests = Admin.getCasesByMobileNumber(search_tag)
    elsif search_tag.email?
       @requests = Admin.getCasesByEmail(search_tag)
    elsif search_tag.include?('+') || search_tag.include?('-')
       @requests = Admin.getCasesByBloodType(search_tag)
    end 
  end

  ##########################################
  # history of cases 
  def caseshistory
    session[:return_to] = caseshistory_controls_path
    @requests = Admin.today_submittedRequests 
  end

  def historyregisteredCases
    session[:return_to] = historyregisteredCases_controls_path
    date= session[:date]
    @requests = Admin.last_registeredCases(date)
  end

  def showcase
    session[:return_to] = showcase_controls_path
    if session[:return] == 'deletecase_controls_path'
      session.delete(:return)
      redirect_to controls_path
    else
      @request = Request.find(session[:request_id])
    end
  end

  def chartsreports
    @userspermonth = Admin.getUsersChartPerMonth
    @requestspermonth = Admin.getRequestsChartPerMonth
    @usersperday = Admin.getUsersChartPerDay
    @requestsperday = Admin.getRequestsChartPerDay
  end
  
  def showdonorinfo
    session[:return_to] = controls_path
    @user = User.find(session[:user_id])
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

  def newdonor
    session[:return_to] = newdonor_controls_path
    @user = User.new
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