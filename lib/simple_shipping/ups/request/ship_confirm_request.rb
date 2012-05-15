module SimpleShipping::Ups
  class ShipConfirmRequest < Request
    def initialize(credentials, shipment)
      @credentials = credentials
      @shipment = shipment
      @type = "v11:ShipConfirmRequest"
    end

    # Builds a request from {Shipment shipment} object.
    def body(opts = {})
      { 'v12:Request' => {
          'v12:RequestOption' => REQUEST_OPTION
        },
        'v11:Shipment' => ShipmentBuilder.build(@shipment, opts),
        'v11:LabelSpecification' => label_specification,
        :order! => ['v12:Request', 'v11:Shipment', 'v11:LabelSpecification']
      }
    end
  end
end
