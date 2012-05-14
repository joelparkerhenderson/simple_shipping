module SimpleShipping::Ups
  class ShipmentRequest < Request
    def initialize(credentials, shipment)
      super
      @type = "v11:ShipmentRequest"
    end
  end
end
