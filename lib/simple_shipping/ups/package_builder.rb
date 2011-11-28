class SimpleShipping::Ups::PackageBuilder < SimpleShipping::Abstract::Builder
  PACKAGING_TYPES = {
    :envelope => '01',  # letter
    :your     => '02',  # customer supplied
    :tube     => '03',  # tube
    :pak      => '04',  # UPS Packaging
    :box      => '2b',  # medium box
    :box_10kg => '25',  
    :box_10kg => '24'
  }
  WEIGHT_UNITS = {
    :kg => 'KGS',
    :lb => 'LBS'
  }
  DIMENSION_UNITS = {
    :in => 'IN',
    :cm => 'CM'
  }

  def build
    { 
      'v11:Packaging' => {
	'v11:Code' => PACKAGING_TYPES[@model.packaging_type]
      },
      'v11:Dimensions' => {
	'v11:UnitOfMeasurement' => {
	  'v11:Code' => DIMENSION_UNITS[@model.dimension_units]
	},
	'v11:Length' => @model.length,
	'v11:Width'  => @model.width,
	'v11:Height' => @model.height,
	:order! => ['v11:UnitOfMeasurement', 'v11:Length', 'v11:Width', 'v11:Height']
      },
      'v11:PackageWeight' => {
	'v11:UnitOfMeasurement' => {
	  'v11:Code' => WEIGHT_UNITS[@model.weight_units]
	},
	'v11:Weight' => @model.weight,
	:order! => ['v11:UnitOfMeasurement', 'v11:Weight']
      },
      :order! => ['v11:Packaging', 'v11:Dimensions', 'v11:PackageWeight']
    }
  end
end
