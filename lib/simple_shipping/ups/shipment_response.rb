# A wrapper for UPS ShipmentResponse
module SimpleShipping::Ups
  class ShipmentResponse < Response
    include SharedResponseAttributes
  end
end
