require 'Obfuscate'

class User < ActiveRecord::Base

  include Obfuscate
  
  BETWEEN_DONATIONS = 90
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :message=> "Must enter your name!"
  
  validates_presence_of :phone, :message=> "Must enter your Mobile number!"
  validates_length_of :phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :phone, :message=> "Must enter mobile number in numerical form only!"
  validates_uniqueness_of :phone, :message=> "This mobile number is already associated with another user!"
  
  validates_presence_of :nationalid, :message=> "Must enter your ID!"
  validates_length_of :nationalid, minimum: 14, maximum: 14, :message=> "National id must be of length 14.."
  validates_numericality_of :nationalid, :message=> "Must enter national id in numerical form only!"
  validates_uniqueness_of :nationalid, :message=> "This national id is already associated with another user!"
  
  ##### Methods #####
  def able_to_donate?
    if (DateTime.now - lastdonation).to_i > BETWEEN_DONATIONS
      true
    else
      false
    end
  end

  def self.get_myblood_requests(blood_type)
    @requests = Request.select("*").where('blood_type = ? and expiredate >= ?', blood_type.to_s, Date.today).order('created_at DESC')
  end

  def self.my_active_donations(current_user) 
      @active_requests = ActiveRequest.select("*").where('donor_id = ? ' , current_user.id.to_s).order('created_at DESC') 
      
      @requests = []

      @active_requests.each do |active_request| 
         if Request.exists?(active_request.request_id)
            @requests << Request.find( active_request.request_id )
         end
      end 

      current_user.update_attribute(:num_of_active_requests,@requests.size)

      @requests
  end
  
  def self.getUsersHideThierAccounts
    @users_ids = User.select("id").where('hide_account = ? ', true)
  end

  def to_param
    encrypt id
  end

end
