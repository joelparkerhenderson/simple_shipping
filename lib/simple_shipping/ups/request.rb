module SimpleShipping::Ups
  # Builds complete request for UPS 
  class Request < SimpleShipping::Abstract::Request
    REQUEST_OPTION = 'nonvalidate'

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
