module SimpleShipping::Fedex
  # Builds complete for Fedex service.
  class Request < SimpleShipping::Abstract::Request
    extend ActiveSupport::Autoload

    autoload :ShipmentRequest

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
       :order! => ['WebAuthenticationDetail', 'ClientDetail', 'Version', 'RequestedShipment'] }
    end

    def web_authentication_detail
      { 'UserCredential' => {'Key'      => @credentials.key,
                             'Password' => @credentials.password,
                             :order!    => ['Key', 'Password']}}
    end
    private :web_authentication_detail

    def client_detail
      {'AccountNumber' => @credentials.account_number,
       'MeterNumber'   => @credentials.meter_number,
       :order!         => ['AccountNumber', 'MeterNumber']}
    end
    private :client_detail

    def version
      {'ServiceId'    => 'ship',
       'Major'        => '10',
       'Intermediate' => '0',
       'Minor'        => '0',
       :order!        => ['ServiceId', 'Major', 'Intermediate', 'Minor']}
    end
    private :version
  end
end
