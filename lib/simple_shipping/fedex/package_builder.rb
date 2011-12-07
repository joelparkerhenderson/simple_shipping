class SimpleShipping::Fedex::PackageBuilder < SimpleShipping::Abstract::Builder
  WEIGHT_UNITS = {:kg => 'KG',
                  :lb => 'LB'}
  DIMENSION_UNITS = {:in => 'IN',
                     :cm => 'CM'}
  
  def build
    { 'Weight'     => {'Units' => WEIGHT_UNITS[@model.weight_units],
                       'Value' => @model.weight,
                       :order! => ['ins0:Units', 'ins0:Value']},
      'Dimensions' => {'Length' => @model.weight,
                       'Width'  => @model.width,
                       'Height' => @model.height,
                       'Units'  => DIMENSION_UNITS[@model.dimension_units],
                       :order!  => ['ins0:Length', 'ins0:Width', 'ins0:Height', 'ins0:Units']},
      :order! => ['ins0:Weight',  'ins0:Dimensions']}
  end
end
