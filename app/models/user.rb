require 'Obfuscate'

class User < ActiveRecord::Base

  include Obfuscate
  
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
  
  def to_param
    encrypt id
  end
end
