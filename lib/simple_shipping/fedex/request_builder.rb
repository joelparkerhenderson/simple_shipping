module SimpleShipping::Fedex
  class RequestBuilder < SimpleShipping::Abstract::RequestBuilder
    def build_request(shipment, opts)
      {'WebAuthenticationDetail' => build_web_authentication_detail,
       'ClientDetail'            => build_client_detail,
       'Version'                 => build_version,
       'RequestedShipment'       => ShipmentBuilder.build(shipment, opts),
       :order! => ['ins0:WebAuthenticationDetail', 'ins0:ClientDetail', 'ins0:Version', 'ins0:RequestedShipment'] }
    end


    private

    def build_web_authentication_detail
      { 'UserCredential' => {'Key'      => @credentials.key,
			     'Password' => @credentials.password,
			     :order!    => ['ins0:Key', 'ins0:Password']}}
    end

    def build_client_detail
      {'AccountNumber' => @credentials.account_number,
       'MeterNumber'   => @credentials.meter_number,
       :order!         => ['ins0:AccountNumber', 'ins0:MeterNumber']}
    end

    def build_version
      {'ServiceId'    => 'ship',
       'Major'        => '10',
       'Intermediate' => '0',
       'Minor'        => '0',
       :order!        => ['ins0:ServiceId', 'ins0:Major', 'ins0:Intermediate', 'ins0:Minor']}
    end

  end
end
