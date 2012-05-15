module SimpleShipping::Ups
  class ShipAcceptRequest < Request
    def initialize(credentials, shipment_digest)
      @credentials = credentials
      @shipment_digest = shipment_digest
      @type = "v11:ShipAcceptRequest"
    end

    def body(opts = {})
      { 'v12:Request' => {
          'v12:RequestOption' => REQUEST_OPTION
        },
        'v11:ShipmentDigest' => @shipment_digest,
        :order! => ['v12:Request', 'v11:ShipmentDigest']
      }
    end
  end
end
