class ControlsController < ApplicationController
  before_action :authenticate_logging_in, only: [:dashboard]
  
  def dashboard
    system = Admin.new 
    @users_number = system.getNumberofUsers 
    @requests_number = system.getNumberofAllRequests
    @active_requests_number  = system.getNumberofActiveRequests
    @expired_requests_number  = system.getNumberofExpiredRequests
  end 
 
  private
    #authenticate user
    def authenticate_logging_in
      if current_admin === nil
        redirect_to new_admin_session_path , notice: "You must login first!"       
      end
    end

    def set_user 
      @admin = Admin.find( Admin.decrypt(params[:id]) )
    end 
end
