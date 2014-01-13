module SimpleShipping
  # Represents an address information of {SimpleShipping::Party party}.
  # == Attributes:
  # * _country_code_
  # * _state_code_
  # * _city_
  # * _street_line_
  # * _street_line_2_
  # * _street_line_3_
  # * _postal_code_
  class Address < Abstract::Model
    attr_accessor :country_code,
                  :state_code,
                  :city,
                  :street_line,
                  :street_line_2,
                  :street_line_3,
                  :postal_code

    validates_presence_of :country_code, :state_code, :city, :street_line, :postal_code
  end
end
