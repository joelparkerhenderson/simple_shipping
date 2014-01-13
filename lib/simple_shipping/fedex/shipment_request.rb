module SimpleShipping::Fedex
  # The model that represents shipment request to FedEx.
  class ShipmentRequest < Request
    def initialize(credentials, shipment)
      super
      @type = :process_shipment
    end

    # :nodoc:
    def response_class
      ShipmentResponse
    end
  end
end
