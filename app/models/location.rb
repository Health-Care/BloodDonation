class Location 

  field :coordinates, type: Array  # [latitude:float, longitude:float]
  field :country, type: String, default: "Egypt"
  field :city, type: String
  field :province, type: String
  field :address, type: String
    
  reverse_geocoded_by :full_address
  # after_validation :reverse_geocode  # auto-fetch ad

  belongs_to :locatable, polymorphic: true

  def full_address
    "#{address}, #{province}, #{city}, #{country}"
  end
end