class AdmincommandsController < ApplicationController

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

   def delete
    @admin = Admin.new  
    @admin.id = params[:controls][:id] 

    if @admin.delete
      redirect_to admins_controls_path, notice: "successfully Deleted this admin!"
    else
      redirect_to admins_controls_path, notice: "Something error, try again"  
    end
  end

  def email_exist(email , id)
    @admins = Admin.all
    @admins.each do |admin|
      if admin.email == email && admin.id != id
          return true
      end
    end
    false    
  end

  def update
    @admin = Admin.new  
    @admin.id = params[:controls][:id]
    @admin.email = params[:controls][:email]
    @admin.password = params[:controls][:password]

    if @admin.password == nil || @admin.email == nil
      redirect_to admins_controls_path, notice: "Please insert email and password fields"
    elsif email_exist(@admin.email ,  @admin.id )
      redirect_to admins_controls_path, notice: "This email already signed to another admin"    
    elsif @admin.update
      redirect_to admins_controls_path, notice: "successfully updated this admin"
    end
   end

   def edit
    @admin = Admin.new  
    @admin.id = 1
    @admin.email = params[:controls][:email]
    @admin.password = params[:controls][:password]
    password_confirmation = params[:controls][:password_confirmation]

    if password_confirmation != @admin.password
      redirect_to edit_admin_controls_path, notice: "Incorrect passwords, try again"
    elsif email_exist(@admin.email , 1)
      redirect_to edit_admin_controls_path, notice: "This email already signed to another admin"    
    elsif @admin.update
      redirect_to controls_path, notice: "successfully updated this admin"
    end
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

    if @user.blood_type == "Choose blood type"
      redirect_to newdonor_controls_path , notice: "Please enter blood type field"
    elsif @user.gender == "Choose gender"
      redirect_to newdonor_controls_path , notice: "Please enter the gender field"
    elsif !User.where(:email => @user.email).blank?
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

  def create_new_case
    @request = Request.new
    @request.contact_name = params[:controls][:contact_name]
    @request.contact_email = params[:controls][:contact_email]
    @request.contact_phone = params[:controls][:contact_phone]
    @request.contact_nationalid = params[:controls][:contact_nationalid]
    @request.blood_type = params[:controls][:blood_type]
    @request.bloodbag = params[:controls][:bloodbag]
    @request.patient_name = params[:controls][:patient_name]
    @request.expiredate = params[:controls][:expiredate]
    @request.hospital_location_lng = params[:controls][:hospital_location_lat]
    @request.hospital_location_lat = params[:controls][:hospital_location_lng]
    @request.hospital_location = params[:controls][:hospital_location]
    @request.hospital_name = params[:controls][:hospital_name]
    @request.created_at = params[:controls][:created_at]
    @request.num_of_donors = params[:controls][:num_of_donors]
    
    if @request.contact_nationalid.length != 14
      redirect_to newcase_controls_path , notice: "Please make sure that national ID is 14 number"
    elsif @request.contact_phone.length != 11
      redirect_to newcase_controls_path , notice: "Please make sure that mobile number is 11 number"
    elsif @request.blood_type == "Choose blood type"
      redirect_to newcase_controls_path , notice: "Please enter blood type field"
    else
      @request.save
      redirect_to controls_path, notice: "successfully create a new case"
    end
  end
  
  # search about donor
  def searchdonor
    search_tag = params[:controls][:search_tag]
    
    if search_tag.numeric?
       @user_id = Admin.getDonorByMobileNumber(search_tag)
    elsif search_tag.email?
       @user_id = Admin.getDonorByEmail(search_tag)
    else
       @user_id = nil
    end

    if @user_id
      session[:user_id] = @user_id
      redirect_to showdonorinfo_controls_path
    else
      redirect_to controls_path, :notice => 'There is no donor matches your search'
    end
  end 

  # search about case
  def searchcase
    session[:search_tag] = params[:controls][:search_tag]
    redirect_to showcases_controls_path
  end 

  # delete cases from , to
  def deletecasesfromto
    from = params[:controls][:from]
    to = params[:controls][:to]
    Admin.deleteCasesFromTO(from,to)
    redirect_to controls_path, :notice => 'Successfully deleted those cases'
  end

  def search_registerd_users
    date = params[:controls][:date]
    session[:date] = date
    redirect_to historyregisteredDonors_controls_path
  end

  def request_donors
    session[:request_id] = params[:controls][:request_id]
    redirect_to requestdonors_controls_path
  end

  def case
    session[:request_id] = params[:controls][:request_id]
    redirect_to showcase_controls_path
  end

  def donor
    session[:user_id] = params[:controls][:user_id]
    redirect_to showdonor_controls_path
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
    session[:return] = 'deletecase_controls_path'
    Admin.deleteCase(request_id)
    redirect_to session.delete(:return_to), :notice => 'Successfully you delete this case'
  end

  ######################################
  def update_donor
    @user = User.find(session[:user_id])
    @user.update_attribute(:name, params[:controls][:name])
    @user.update_attribute(:gender, params[:controls][:gender])
    @user.update_attribute(:birth_date, params[:controls][:birth_date])
    @user.update_attribute(:location_name, params[:controls][:location_name])
    @user.update_attribute(:location_lat, params[:controls][:location_lat])
    @user.update_attribute(:location_lng, params[:controls][:location_lng])
    @user.update_attribute(:blood_type, params[:controls][:blood_type])
    @user.update_attribute(:password, params[:controls][:password])
    @user.update_attribute(:hide_account, params[:controls][:hide_account])
    @user.update_attribute(:can_donate, params[:controls][:can_donate])
    @user.update_attribute(:stop_getting_email, params[:controls][:stop_getting_email])
    @user.update_attribute(:savedpeople, params[:controls][:savedpeople])
    @user.update_attribute(:lastdonation, params[:controls][:lastdonation])
    @user.update_attribute(:num_of_active_requests, params[:controls][:num_of_active_requests])
    
    param1 = Admin.valid_email_param(@user, params[:controls][:email])
    param2 = Admin.valid_phone_param(@user, params[:controls][:phone])
    param3 = Admin.valid_nationalid_param(@user, params[:controls][:nationalid])
    if param1 === "ok" && param1 === param2 && param1 === param3
       @user.update_attribute(:email, params[:controls][:email])
       @user.update_attribute(:phone, params[:controls][:phone])
       @user.update_attribute(:nationalid, params[:controls][:nationalid])
       redirect_to showdonor_controls_path, notice: "successfully updated this user"
    elsif param1 != "ok"
       redirect_to showdonor_controls_path, notice: param1 
    elsif param2 != "ok"
       redirect_to showdonor_controls_path, notice: param2 
    elsif param3 != "ok"
       redirect_to showdonor_controls_path, notice: param3 
    end
  end

  def deletedonor
    user_id = params[:controls][:user_id]
    Admin.deleteDonor(user_id)
    redirect_to session.delete(:return_to), :notice => "successfully Deleted this donor!"
  end
  def expire
    request_id = params[:controls][:request_id]
    Request.find(request_id).update_attribute(:expiredate,'2010-10-10')
    
    redirect_to session.delete(:return_to) , :notice => 'Successfully you mark this case as expired'
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
  
  def search_registerd_cases
    date = params[:controls][:date]
    session[:date] = date
    redirect_to historyregisteredCases_controls_path
  end

  #confirm donation process
  def confirm_donation
    user_id = params[:controls][:user_id]
    request_id = session[:request_id]
    Admin.confirmDonationProcess(user_id,request_id)
    redirect_to requestdonors_controls_path, :notice => 'Successfully confirm this donation'
  end

  #cancel donation process
  def cancel_donation
    user_id = params[:controls][:user_id]
    request_id = session[:request_id]
    Admin.cancelDonationProcess(user_id,request_id)
    redirect_to requestdonors_controls_path, :notice => 'Successfully cancel this donation'
  end
end
