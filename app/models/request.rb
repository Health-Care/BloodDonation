require 'Obfuscate'

class Request < ActiveRecord::Base

  include Obfuscate

  
  validates_presence_of :contact_name, :message=> "Must enter your name!"
  
  validates_presence_of :contact_phone, :message=> "Must enter your Mobile number!"
  validates_length_of :contact_phone, minimum: 11, maximum: 11, :message=> "Mobile number must be of length 11.."
  validates_numericality_of :contact_phone, :message=> "Must enter mobile number in numerical form only!"
 
  validates_presence_of :contact_email, :message=> "Must enter your contact email!"
  
  validates_presence_of :contact_nationalid, :message=> "Must enter your ID!"
  validates_length_of :contact_nationalid, minimum: 14, maximum: 14, :message=> "National id must be of length 14.."
  validates_numericality_of :contact_nationalid, :message=> "Must enter national id in numerical form only!"
 
  validates_presence_of :patient_name, :message=> "Must enter patient name!"
  validates_presence_of :hospital_name, :message=> "Must enter hospital name!"
  validates_presence_of :bloodbag, :message=> "Must enter number of bloodbag!"
  validates_presence_of :blood_type, :message=> "Must enter the blood type"
  validates_presence_of :expiredate, :message=> "Must enter the expire date"

  def to_param
    encrypt id
  end
end
