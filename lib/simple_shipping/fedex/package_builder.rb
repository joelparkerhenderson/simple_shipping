module SimpleShipping::Fedex
  # Knows how to convert {Package} model to SOAP element for FedEx.
  class PackageBuilder < SimpleShipping::Abstract::Builder
    # FedEx mapping for weight units.
    WEIGHT_UNITS = {:kg => 'KG',
                    :lb => 'LB'}
    # FedEx mapping for dimension units.
    DIMENSION_UNITS = {:in => 'IN',
                       :cm => 'CM'}
    
    # Build a SOAP package element as a hash for Savon.
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
