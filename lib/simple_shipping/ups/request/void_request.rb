module SimpleShipping::Ups
  class VoidRequest < Request
    def initialize(credentials, shipment_identification_number, tracking_number = nil)
      @credentials = credentials
      @shipment_identification_number = shipment_identification_number
      @tracking_number = tracking_number
      @type = "v11:VoidShipmentRequest"
    end

    # Builds a request from {Shipment shipment} object.
    def body(opts = {})
      {
        'v12:Request' => {
          'v12:RequestOption' => REQUEST_OPTION
        },
        'v11:VoidShipment' => void_shipment,
        :order! => ['v12:Request', 'v11:VoidShipment']
      }
    end

    def void_shipment
      data = { 'v11:ShipmentIdentificationNumber' => @shipment_identification_number }

      if @tracking_number
        data.merge!(
          'v11:TrackingNumber' => @tracking_number,
          :order! => ['v11:ShipmentIdentificationNumber', 'v11:TrackingNumber']
        )
      end

      data
    end
  end
end
