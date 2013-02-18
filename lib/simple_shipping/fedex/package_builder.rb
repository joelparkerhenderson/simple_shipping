module SimpleShipping::Fedex
  # Knows how to convert {Package} model to SOAP element for Fedex.
  class PackageBuilder < SimpleShipping::Abstract::Builder
    # Fedex mapping for weight units
    WEIGHT_UNITS = {:kg => 'KG',
                    :lb => 'LB'}
    # Fedex mapping for dimension units
    DIMENSION_UNITS = {:in => 'IN',
                       :cm => 'CM'}
    
    # Builds a SOAP package element as a hash for Savon.
    def build
      { 'Weight'     => {'Units' => WEIGHT_UNITS[@model.weight_units],
                         'Value' => @model.weight,
                         :order! => ['Units', 'Value']},
        'Dimensions' => {'Length' => @model.length,
                         'Width'  => @model.width,
                         'Height' => @model.height,
                         'Units'  => DIMENSION_UNITS[@model.dimension_units],
                         :order!  => ['Length', 'Width', 'Height', 'Units']},
        :order! => ['Weight',  'Dimensions']}
    end
  end
end
