# Builds hash for Savon which represents {Package package}
module SimpleShipping::Ups
  class PackageBuilder < SimpleShipping::Abstract::Builder
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

    # Custom package order
    CUSTOM_PACKAGE_ORDER = %w(Packaging PackageServiceOptions Dimensions PackageWeight)

    # Standard package order
    STANDARD_PACKAGE_ORDER = %w(Packaging PackageServiceOptions PackageWeight)

    def base_package
      base = {
        'Packaging' => {
          'Code' => PACKAGING_TYPES[@model.packaging_type]
        },
        'PackageWeight' => {
          'UnitOfMeasurement' => {
            'Code' => WEIGHT_UNITS[@model.weight_units]
          },
          'Weight' => @model.weight,
          :order! => ['UnitOfMeasurement', 'Weight']
        },
        'PackageServiceOptions' => {}
      }

      if @model.insured_value
        base['PackageServiceOptions']['InsuredValue'] = {
          'CurrencyCode' => 'USD',
          'MonetaryValue' => @model.insured_value
        }
      end

      if @model.declared_value
        base['PackageServiceOptions']['DeclaredValue'] = {
          'CurrencyCode' => 'USD',
          'MonetaryValue' => @model.declared_value
        }
      end

      base
    end

    # Build a hash from a custom {Package package} which will be used by Savon.
    # A custom package requires specification of LWH dimensions.
    def custom_package
      base_package.tap do |package|
        package['Dimensions'] = {
          'UnitOfMeasurement' => {
            'Code' => DIMENSION_UNITS[@model.dimension_units].clone
          },
          'Length' => @model.length,
          'Width'  => @model.width,
          'Height' => @model.height,
          :order! => ['UnitOfMeasurement', 'Length', 'Width', 'Height']
        }
        package[:order!] = CUSTOM_PACKAGE_ORDER.clone
      end
    end

    # Build a hash from a standard {Package package} which will be used by Savon.
    # A standard package requires no specification of LWH dimensions.
    def standard_package
      base_package.tap do |package| 
        package[:order!] = STANDARD_PACKAGE_ORDER.clone
      end
    end

    def build
      @model.custom_package? ? custom_package : standard_package
    end
  end
end
