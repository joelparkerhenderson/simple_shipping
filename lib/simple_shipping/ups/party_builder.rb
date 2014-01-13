module SimpleShipping::Ups
  # Knows how to convert {Party} model to SOAP element for UPS.
  class PartyBuilder < SimpleShipping::Abstract::Builder
    # Builds a hash for Savon which represents {Party party}.
    def build
      contact = @model.contact
      {'Name'          => (contact.person_name || contact.company_name),
       'Phone'         => {'Number' => contact.phone_number},
       'ShipperNumber' => @model.account_number,
       'Address'       => build_address,
       :order!         => ['Name', 'Phone', 'ShipperNumber', 'Address']
      }
    end

    # Build address element.
    #
    # @return [Hash]
    def build_address
      addr = @model.address
      {'AddressLine'       => [addr.street_line, addr.street_line_2, addr.street_line_3].compact,
       'City'              => addr.city,
       'StateProvinceCode' => addr.state_code,
       'PostalCode'        => addr.postal_code,
       'CountryCode'       => addr.country_code,
       :order!             => ['AddressLine', 'City', 'StateProvinceCode', 'PostalCode', 'CountryCode']
      }
    end

    # Validate presence of account_number.
    #
    # @return [void]
    def validate
      if @opts[:shipper] && !@model.account_number
        raise SimpleShipping::ValidationError.new("account_number is required for party who is shipper")
      end
    end
  end
end
