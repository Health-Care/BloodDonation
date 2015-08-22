class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  def getNumberofUsers
  	User.count 
  end

  def getNumberofActiveRequests
  	Request.select("*").where('expiredate >= ? ' , Date.today).count 
  end

  def getNumberofAllRequests
  	Request.count 
  end

  def getNumberofExpiredRequests
  	Request.select("*").where('expiredate <? ' , Date.today).count 
  end

  def getNumberofAdmins
  	Admin.count 
  end

  def delete
  	Admin.find(self.id).destroy
  end

  def update
  	Admin.find(self.id).update_attribute(:email , self.email)
  	Admin.find(self.id).update_attribute(:password , self.password)
  end

  def exist?
  	if User.where(:email => self.email).blank?
  	  false
  	else
  	  true
  	end    	
  end
end
