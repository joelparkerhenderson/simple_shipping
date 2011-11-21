class SimpleShipping::Ups::PackageBuilder < SimpleShipping::Abstract::Builder
  TYPE_CODES = {:letter            => '01',
                :customer_supplied => '02',
                :tube              => '03',
                :pak               => '04',
                :express_box       => '21',
                :box_25kg          => '24',
                :box_10kg          => '25',
                :pallet            => '30',
                :small_box         => '2a',
                :medium_box        => '2b',
                :large_box         => '2c'}

  WEIGHT_UNITS = {:kg => 'KGS',
                  :lb => 'LBS'}

  DIMENSION_UNITS = {:in => 'IN',
                     :cm => 'CM'}

  
  def build
    { 
      'v11:Packaging' => {
	'v11:Code' => TYPE_CODES[@model.type_code]
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
