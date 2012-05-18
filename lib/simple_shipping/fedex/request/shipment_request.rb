module SimpleShipping::Fedex
  class ShipmentRequest < Request
    def initialize(credentials, shipment)
      super
      @type = "ProcessShipmentRequest"
    end

    def response_class
      ShipmentResponse
    end
  end
end
