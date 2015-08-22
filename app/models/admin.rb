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
end
