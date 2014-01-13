module SimpleShipping::Ups
  # UPS request to void shipment.
  class VoidRequest < Request

    # @param credentials [Hash]
    # @param shipment_identification_number [String]
    # @param options [Hash]
    def initialize(credentials, shipment_identification_number, options = {})
      @credentials                    = credentials
      @shipment_identification_number = shipment_identification_number
      @tracking_number                = options[:tracking_number]
      @options                        = options
      @type                           = :process_void
    end

    # Build a request from a {Shipment shipment} object.
    def body
      {
        'common:Request' => {
          'common:RequestOption' => REQUEST_OPTION
        },
        'VoidShipment' => void_shipment,
        :order!        => ['common:Request', 'VoidShipment']
      }
    end

    # Data for VoidShipment.
    #
    # @return [Hash]
    def void_shipment
      data = { 'ShipmentIdentificationNumber' => @shipment_identification_number }

      if @tracking_number
        data['TrackingNumber'] = @tracking_number
        data[:order!]          = ['ShipmentIdentificationNumber', 'TrackingNumber']
      end

      data
    end
    private :void_shipment
  end
end
