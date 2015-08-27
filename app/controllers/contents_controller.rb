class ContentsController < ApplicationController

	#before_action :authenticate_user!
	
	def index 
		if user_signed_in?
			#User.my_active_donations(current_user)			
			#redirect_to show_users_path(current_user)
			redirect_to relatedrequests_requests_path
		elsif admin_signed_in?
			redirect_to controls_path   
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
