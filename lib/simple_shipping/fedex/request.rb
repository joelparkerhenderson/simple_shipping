module SimpleShipping::Fedex
  # Builds complete for Fedex service.
  class Request < SimpleShipping::Abstract::Request

    def initialize(credentials, shipment)
      super(credentials)
      @shipment = shipment
    end

    # Build complete request from {Shipment shipment} object
    def body(opts = {})
      {'WebAuthenticationDetail' => web_authentication_detail,
       'ClientDetail'            => client_detail,
       'Version'                 => version,
       'RequestedShipment'       => ShipmentBuilder.build(@shipment, opts),
       :order! => ['ins0:WebAuthenticationDetail', 'ins0:ClientDetail', 'ins0:Version', 'ins0:RequestedShipment'] }
    end

    def web_authentication_detail
      { 'UserCredential' => {'Key'      => @credentials.key,
                             'Password' => @credentials.password,
                             :order!    => ['ins0:Key', 'ins0:Password']}}
    end
    private :web_authentication_detail

    def client_detail
      {'AccountNumber' => @credentials.account_number,
       'MeterNumber'   => @credentials.meter_number,
       :order!         => ['ins0:AccountNumber', 'ins0:MeterNumber']}
    end
    private :client_detail

    def version
      {'ServiceId'    => 'ship',
       'Major'        => '10',
       'Intermediate' => '0',
       'Minor'        => '0',
       :order!        => ['ins0:ServiceId', 'ins0:Major', 'ins0:Intermediate', 'ins0:Minor']}
    end
    private :version
  end
end
