module SimpleShipping::Ups
  class ShipConfirmRequest < Request
    def initialize(credentials, shipment)
      super
      @type = "v11:ShipConfirmRequest"
    end
  end
end
