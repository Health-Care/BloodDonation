class RequestsController < ApplicationController
  before_action :authenticate_logging_in, only: [:edit, :show, :donate, :relatedrequests, :cancel_donate]
  before_action :set_request, only: [:show, :edit, :update, :destroy, :donate, :cancel_donate] 

  # GET /requests
  # GET /requests.json
  def index  
    @requests = Request.select("*").where('expiredate >= ? ' , Date.today).order('created_at DESC') 
  end

  # GET /requests/1
  # GET /requests/1.json
  def show 

    UserMailer.new_request_email(current_user, @request).deliver_now

    if current_user.blood_type != @request.blood_type
      respond_to do |format|
      format.html { redirect_to requests_path, notice: 'The requests blood type doesnt match yours' }
      format.json { head :no_content } 
      end
    end 
  end

  def donate
    @active_request = ActiveRequest.new
    @active_request.donor_id = current_user.id
    @active_request.request_id = @request.id

    if check_donations_status(current_user.id,@request.id)
    
        if @request.num_of_donors == nil 
           Request.find( @request.id ).update_attribute(:num_of_donors, 1)
        else
           Request.find( @request.id ).update_attribute(:num_of_donors, @request.num_of_donors + 1)
        end   
        
        if current_user.num_of_active_requests == nil 
           User.find( current_user.id ).update_attribute(:num_of_active_requests, 1)
        else
           User.find( current_user.id ).update_attribute(:num_of_active_requests, @current_user.num_of_active_requests + 1)
        end       
    end

    respond_to do |format|
      if check_donations_status(current_user.id,@request.id) and @active_request.save 
        format.html { redirect_to @request, notice: 'You successfully responded to the request.. He should be waiting for you there' }
        format.json { render :show, status: :created, location: @request }
      else
        if current_user.pause
           format.html { redirect_to @request, notice: "Your account paused, please if you have a problem call us" }
        else
           format.html { redirect_to @request, notice: "You are donated before" }
        end      
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end 

  end

  def cancel_donate
      User.find( current_user.id ).update_attribute(:num_of_active_requests, @current_user.num_of_active_requests - 1)
      Request.find( @request.id ).update_attribute(:num_of_donors, @request.num_of_donors - 1)

      respond_to do |format|
      if ActiveRequest.where(:donor_id => current_user.id,:request_id => @request.id).destroy_all
        format.html { redirect_to active_donations_users_path(current_user), notice: 'successfully cancel this active donation' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { redirect_to active_donations_users_path(current_user), notice: "Some thing went wrong, please call the call center" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end 

  end

  def check_donations_status(donor_id,request_id)
    if ActiveRequest.where(:donor_id => donor_id,:request_id => request_id).blank?
      true
    else
      false
    end
  end

  def relatedrequests
    #current_user.notifications = 0;
    #User.where("id == 'current_user.id'").update_all("notifications = 0")
    
    @new_requests = Request.select("*").where('blood_type == ? and expiredate >= ?',current_user.blood_type, Date.today).order('created_at DESC').limit(current_user.notifications)
    @old_requests = Request.select("*").where('blood_type == ? and expiredate >= ?',current_user.blood_type, Date.today).order('created_at DESC').offset(current_user.notifications)

    User.all.each do |user| 
      if user.id == current_user.id
        user.update_attribute(:notifications, 0)
      end  
    end

  end

  # GET /requests/new
  def new
    @request = Request.new      
    #User.where("faselty == 'faselty_request'").update_all("notifications = notifications + 1")
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save

        User.all.each do |user| 
          if user.blood_type.to_s == @request.blood_type.to_s
            user.update_attribute(:notifications, user.notifications + 1);
          end  
        end

        format.html { redirect_to root_url, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { redirect_to root_url, alert: "Something went wrong" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      params.require(:request).permit(:contact_name, :contact_phone, :contact_email, :contact_nationalid, :patient_name, :blood_type, :expiredate, :bloodbag, :hospital_name, :hospital_location, :hospital_location_lat,:hospital_location_lng)
    end
end
