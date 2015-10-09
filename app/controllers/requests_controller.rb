class RequestsController < ApplicationController
  before_action :authenticate_logging_in, only: [:donors, :show, :donate, :relatedrequests, :cancel_donate]
  before_action :set_request, only: [:donors, :show, :update, :donate, :cancel_donate] 
  
  # GET /requests
  # GET /requests.json
  def index    
    @requests = Request.get_unexpired_requests
  end

  # GET /requests/1
  # GET /requests/1.json
  def show 
    donors
    if current_user.blood_type != @request.blood_type
       redirect_to requests_path, notice: 'The requests blood type does not match yours'
    end 
  end

  # GET /requests/new
  def new
    @request = Request.new       
  end 

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        notify_users(@request)
        session[:request_id] = @request.id
        format.html { redirect_to createdrequest_requests_path, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :action => "new" , alert: "Something went wrong, try again" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def createdrequest
    @request = Request.find(session[:request_id])
  end

  def donors  
    @users = Request.my_active_donors(@request)
  end

  def donate
    @active_request = ActiveRequest.new
    @active_request.donor_id = current_user.id
    @active_request.request_id = @request.id

    if ActiveRequest.check_donations_status(current_user.id,@request.id) && !current_user.pause && current_user.can_donate
      notify_request_owner(@request) 

      if @active_request.save 
        redirect_to @request, notice: 'successfully responded to the request. He waiting you'
      end
    
    elsif current_user.pause
        redirect_to @request, notice: "Your account paused, unpause your account to donate" 
    
    elsif !current_user.can_donate
        redirect_to @request, notice: "Your account paused, call us to solve the problem" 
    
    else
        redirect_to @request, notice: "You are donated before"
    end

  end

  def cancel_donate
    ActiveRequest.cancel_donation(current_user,@request)
  
    if ActiveRequest.where(:donor_id => current_user.id,:request_id => @request.id).destroy_all
       redirect_to active_donations_users_path(current_user), notice: 'successfully cancel this active donation' 
    else
       redirect_to active_donations_users_path(current_user), notice: "Some thing went wrong, please try again" 
    end  

  end

  def relatedrequests 
    @requests = User.get_myblood_requests(current_user.blood_type) 
    current_user.update_attribute(:notifications , 0)    
  end


  def notify_users(request)
    users = []

    User.all.each do |user| 
      if user.blood_type.to_s == request.blood_type.to_s
        if !user.stop_getting_email
          users << user
        end
        user.update_attribute(:notifications, user.notifications + 1);
      end
    end  

    Thread.new do
       UserMailer.new_request_email(users, request, request.blood_type).deliver_later
    end

  end


  def notify_request_owner(request)
     Thread.new do
         UserMailer.new_reply_email(current_user, request).deliver_now
     end

     Request.update_num_of_donors(request , current_user)
  end

 private
    #authenticate user
    def authenticate_logging_in
      if current_user === nil
        redirect_to new_user_session_path , notice: "You must login first!"       
      end
    end  

    # check if there is a new notification
    def is_there_notification
      current_user.notifications
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_request
      #@request = Request.find(params[:id])
      @request = Request.find( Request.decrypt(params[:id]) )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:contact_name, :contact_phone, :contact_email, :contact_nationalid, :patient_name, :blood_type, :expiredate, :bloodbag, :hospital_name, :hospital_location, :hospital_location_lat,:hospital_location_lng, :num_of_donors, :created_at)
    end
  end
