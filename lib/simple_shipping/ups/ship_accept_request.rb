module SimpleShipping::Ups
  # Shipping accept request.
  class ShipAcceptRequest < Request
    def initialize(credentials, shipment_digest, options = {})
      @credentials     = credentials
      @shipment_digest = shipment_digest
      @options         = options
      @type            = :prcoess_ship_accept
    end

    # :nodoc:
    def body
      { 'common:Request' => {
          'common:RequestOption' => REQUEST_OPTION
        },
        'ShipmentDigest' => @shipment_digest,
        :order!          => ['common:Request', 'ShipmentDigest']
      }
    end
  end
end
