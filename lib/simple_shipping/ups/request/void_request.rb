module SimpleShipping::Ups
  class VoidRequest < Request
    def initialize(credentials, shipment_identification_number, options = {})
      @credentials = credentials
      @shipment_identification_number = shipment_identification_number
      @tracking_number = options[:tracking_number]
      @options = options
      @type = "v11:VoidShipmentRequest"
    end

    # Builds a request from {Shipment shipment} object.
    def body
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
        data['v11:TrackingNumber'] = @tracking_number
        data[:order!] = ['v11:ShipmentIdentificationNumber', 'v11:TrackingNumber']
      end

      data
    end
    private :void_shipment
  end
end
