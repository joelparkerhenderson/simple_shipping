class SimpleShipping::Address < SimpleShipping::Base::Model
  attr_accessor :country_code,
		:state_code,
                :city,
		:street_line,
		:postal_code

  validates_presence_of :country_code, :state_code, :city, :street_line, :postal_code
end
