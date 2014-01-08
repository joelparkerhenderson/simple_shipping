module SimpleShipping::Ups
  # Request to verify a shipment was delivered.
  class ShipConfirmRequest < Request
    def initialize(credentials, shipment, options = {})
      @credentials = credentials
      @shipment = shipment
      @options = options
      @type = :process_ship_confirm
    end

    # Builds a request from {Shipment shipment} object.
    def body
      { 'common:Request' => {
          'common:RequestOption' => REQUEST_OPTION
        },
        'Shipment' => ShipmentBuilder.build(@shipment, @options),
        'LabelSpecification' => label_specification,
        :order! => ['common:Request', 'Shipment', 'LabelSpecification']
      }
    end
  end
end
