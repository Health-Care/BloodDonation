class ControlsController < ApplicationController
  before_action :authenticate_logging_in, only: [:dashboard]
  
  def dashboard
    system = Admin.new 
    @users_number = system.getNumberofUsers 
    @admins_number = system.getNumberofAdmins
    @requests_number = system.getNumberofAllRequests
    @active_requests_number  = system.getNumberofActiveRequests
    @expired_requests_number  = system.getNumberofExpiredRequests
  end 
  
  def new
    @admin = Admin.new  
  end 

  def create_new_admin
    @admin = Admin.new  
    @admin.email = params[:controls][:email]
    @admin.password = params[:controls][:password]
    password_confirmation = params[:controls][:password_confirmation]

    if password_confirmation != @admin.password
      redirect_to controls_path, notice: "Incorrect passwords, try again"
    elsif @admin.exist?
      redirect_to controls_path, notice: "This email already signed to anther person"    
    else
      if @admin.save 
        redirect_to root_url, notice: 'successfully created a new admin'
      else
        redirect_to controls_path, notice: "Something went wrong, try again"
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
