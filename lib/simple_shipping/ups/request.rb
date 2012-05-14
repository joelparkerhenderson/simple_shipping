module SimpleShipping::Ups
  # Builds complete request for UPS 
  class Request < SimpleShipping::Abstract::Request
    REQUEST_OPTION = 'nonvalidate'

    def initialize(credentials, shipment)
      super(credentials)
      @shipment = shipment
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

    def header
      { 'v1:UPSSecurity' => {
          'v1:UsernameToken' => {
            'v1:Username' => credentials.username,
            'v1:Password' => credentials.password,
            :order!    => ['v1:Username', 'v1:Password']
          },
          'v1:ServiceAccessToken' => {
            'v1:AccessLicenseNumber' => credentials.access_license_number
          }
        }
      }
    end

    def label_specification
      { 'v11:LabelImageFormat' => {'v11:Code' => 'GIF'},
        'v11:LabelStockSize' => {
          'v11:Height' => '6',
          'v11:Width' => '4',
          :order! => ['v11:Height', 'v11:Width']
        },
        :order! => ['v11:LabelImageFormat', 'v11:LabelStockSize']
      }      
    end

    def response_class
      self.class.name.sub(/Request/, 'Response').constantize
    end
    private :response_class
 end
end
