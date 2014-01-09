module SimpleShipping::Fedex
  # Knows how to convert {Party} model to SOAP element for Fedex.
  class PartyBuilder < SimpleShipping::Abstract::Builder
    # Builds a SOAP party element as a hash for Savon.
    def build
      {'Contact' => build_contact,
       'Address' => build_address,
       :order! => ['Contact', 'Address']}
    end

    # Build body for Contact element.
    #
    # @return [Hash]
    def build_contact
      result  = {:order! => []}
      contact = @model.contact
      if contact.company_name
        result['CompanyName'] = contact.company_name
        result[:order!] << 'CompanyName'
      end
      if contact.person_name
        result['PersonName']  = contact.person_name
        result[:order!] << 'PersonName'
      end
      result['PhoneNumber'] = contact.phone_number
      result[:order!] << 'PhoneNumber'
      result
    end
    private :build_contact

    # Build body for Address element.
    #
    # @return [Hash]
    def build_address
      addr = @model.address
      {'StreetLines'         => addr.street_line,
       'City'                => addr.city,
       'StateOrProvinceCode' => addr.state_code,
       'PostalCode'          => addr.postal_code,
       'CountryCode'         => addr.country_code,
       :order! => [ 'StreetLines', 'City', 'StateOrProvinceCode', 'PostalCode', 'CountryCode']
      }
    end
    private :build_address
  end
end
