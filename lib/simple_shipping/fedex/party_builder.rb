class SimpleShipping::Fedex::PartyBuilder < ::SimpleShipping::Abstract::Builder
  def build
    {'Contact' => build_contact,
     'Address' => build_address,
     :order! => ['ins0:Contact', 'ins0:Address']}
  end

  def build_contact
    result = {:order! => []}
    contact = @model.contact
    if contact.company_name
      result['CompanyName'] = contact.company_name
      result[:order!] << 'ins0:CompanyName'
    end
    if contact.person_name
      result['PersonName']  = contact.person_name
      result[:order!] << 'ins0:PersonName'
    end
    result['PhoneNumber'] = contact.phone_number
    result[:order!] << 'ins0:PhoneNumber'
    result
  end

  def build_address
    addr = @model.address
    {'StreetLines'         => addr.street_line,
     'City'                => addr.city,
     'StateOrProvinceCode' => addr.state_code,
     'PostalCode'          => addr.postal_code,
     'CountryCode'         => addr.country_code,
     :order! => [ 'ins0:StreetLines', 'ins0:City', 'ins0:StateOrProvinceCode', 'ins0:PostalCode', 'ins0:CountryCode']
    }
  end
end
