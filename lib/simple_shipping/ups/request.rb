module SimpleShipping::Ups
  # Builds complete request for UPS 
  class Request < SimpleShipping::Abstract::Request
    REQUEST_OPTION = 'nonvalidate'

    def label_specification
      { 'LabelImageFormat' => {'Code' => 'GIF'},
        'LabelStockSize' => {
          'Height' => '6',
          'Width' => '4',
          :order! => ['Height', 'Width']
        },
        :order! => ['LabelImageFormat', 'LabelStockSize']
      }      
    end

    def response_class
      self.class.name.sub(/Request/, 'Response').constantize
    end
    private :response_class
 end
end
