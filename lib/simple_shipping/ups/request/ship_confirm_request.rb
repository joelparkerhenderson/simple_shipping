module SimpleShipping::Ups
  class ShipConfirmRequest < Request
    def initialize(credentials, shipment, options = {})
      @credentials = credentials
      @shipment = shipment
      @options = options
      @type = :process_ship_confirm
    end

    # Builds a request from {Shipment shipment} object.
    def body
      { 'v12:Request' => {
          'v12:RequestOption' => REQUEST_OPTION
        },
        'Shipment' => ShipmentBuilder.build(@shipment, @options),
        'LabelSpecification' => label_specification,
        :order! => ['v12:Request', 'Shipment', 'LabelSpecification']
      }
    end
  end
end
