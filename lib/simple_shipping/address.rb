# Represents an address information of {SimpleShipping::Party party}
# == Attributes:
# * _country_code_
# * _state_code_
# * _city_
# * _street_line_
# * _postal_code_
class SimpleShipping::Address < SimpleShipping::Abstract::Model
  attr_accessor :country_code,
		:state_code,
                :city,
		:street_line,
		:postal_code

  validates_presence_of :country_code, :state_code, :city, :street_line, :postal_code
end
