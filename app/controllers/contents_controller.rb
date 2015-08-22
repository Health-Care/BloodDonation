class ContentsController < ApplicationController

	#before_action :authenticate_user!
	
	def index 
	  if user_signed_in?
         redirect_to show_users_path(current_user)
      elsif admin_signed_in?
         redirect_to dashboard_controls_path   
      end
	end

	def about
	end

	def donor_info
	end

	def donation_info
	end

	def blood_info
	end

	def patient_info
	end

	def news
	end

	def contact
	end
end
