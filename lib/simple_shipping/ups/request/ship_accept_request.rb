module SimpleShipping::Ups
  class ShipAcceptRequest < Request
    def initialize(credentials, shipment_digest, options = {})
      @credentials = credentials
      @shipment_digest = shipment_digest
      @options = options
      @type = :prcoess_ship_accept
    end

    def body
      { 'v12:Request' => {
          'v12:RequestOption' => REQUEST_OPTION
        },
        'v11:ShipmentDigest' => @shipment_digest,
        :order! => ['v12:Request', 'v11:ShipmentDigest']
      }
    end
  end
end
