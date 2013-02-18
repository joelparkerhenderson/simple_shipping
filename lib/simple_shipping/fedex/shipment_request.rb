module SimpleShipping::Fedex
  class ShipmentRequest < Request
    def initialize(credentials, shipment)
      super
      @type = :process_shipment
    end

    def response_class
      ShipmentResponse
    end
  end
end
