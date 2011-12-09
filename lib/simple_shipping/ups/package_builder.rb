# Builds hash for Savon which represents {Package package}
class SimpleShipping::Ups::PackageBuilder < SimpleShipping::Abstract::Builder
  # Mapping for UPS packaging types
  # Not all UPS values listed here in order to provide common interface with Fedex.
  PACKAGING_TYPES = {
    :envelope => '01',  # letter
    :your     => '02',  # customer supplied
    :tube     => '03',  # tube
    :pak      => '04',  # UPS Packaging
    :box      => '2b',  # medium box
    :box_10kg => '25',  
    :box_10kg => '24'
  }

  # Mapping for UPS weight units
  WEIGHT_UNITS = {
    :kg => 'KGS',
    :lb => 'LBS'
  }
  
  # Mapping for UPS dimension units
  DIMENSION_UNITS = {
    :in => 'IN',
    :cm => 'CM'
  }

  # Builds a hash from a {Package package} which will be used by Savon.
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
