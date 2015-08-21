class ActiveRequest < ActiveRecord::Base
	
	def self.cancel_donation(current_user,request)
		User.find( current_user.id ).update_attribute(:num_of_active_requests, current_user.num_of_active_requests - 1)
		Request.find( request.id ).update_attribute(:num_of_donors, request.num_of_donors - 1)
	end

	def self.check_donations_status(donor_id,request_id)
		if ActiveRequest.where(:donor_id => donor_id,:request_id => request_id).blank?
			true
		else
			false
		end
	end
	
end
