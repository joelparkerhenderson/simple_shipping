module SimpleShipping::Ups
  # Builds complete request for UPS 
  class Request < SimpleShipping::Abstract::Request
    REQUEST_OPTION = 'nonvalidate'

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
