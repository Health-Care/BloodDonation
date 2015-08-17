class UsersController < ApplicationController
  before_action :authenticate_logging_in, only: [:show, :active_donations, :pause, :unpause]
  before_action :set_user, only: [:show, :active_donations]
  
  def show  
  end 
 
  def active_donations
   	  @active_requests = ActiveRequest.new	
  	  @active_requests = ActiveRequest.select("*").where('donor_id == ? ' , current_user.id).order('created_at DESC') 
  	  
  	  @requests = []

  	  @active_requests.each do |active_requests| 
          @requests << Request.find( active_requests.request_id )
      end	
  end

  def pause
    if current_user.update_attribute(:pause , true)
      redirect_to root_path, notice: "Successfully paused your donation ability."
    else
      redirect_to root_path, alert: "Something went wrong with your account, plaese call us"
    end
  end

  def unpause
    if current_user.update_attribute(:pause , false)
      redirect_to root_path, notice: "Successfully unpaused your donation ability."
    else
      redirect_to root_path, alert: "Something went wrong with your account, plaese call us"
    end
  end

  private
    #authenticate user
    def authenticate_logging_in
      if current_user === nil
        redirect_to new_user_session_path , notice: "You must login first!"       
      end
    end

    def set_user
      #@user = User.find(params[:id])
      @user = User.find( User.decrypt(params[:id]) )
    end 
end
