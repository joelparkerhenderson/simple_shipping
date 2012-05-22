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
    CUSTOM_PACKAGE_ORDER = %w(v11:Packaging v11:PackageServiceOptions v11:Dimensions v11:PackageWeight).freeze

    # Standard package order
    STANDARD_PACKAGE_ORDER = %w(v11:Packaging v11:PackageServiceOptions v11:PackageWeight).freeze

    def base_package
      base = {
        'v11:Packaging' => {
          'v11:Code' => PACKAGING_TYPES[@model.packaging_type]
        },
        'v11:PackageWeight' => {
          'v11:UnitOfMeasurement' => {
            'v11:Code' => WEIGHT_UNITS[@model.weight_units]
          },
          'v11:Weight' => @model.weight,
          :order! => ['v11:UnitOfMeasurement', 'v11:Weight']
        },
        'v11:PackageServiceOptions' => {}
      }

      if @model.insured_value
        base['v11:PackageServiceOptions']['v11:InsuredValue'] = {
          'v11:CurrencyCode' => 'USD',
          'v11:MonetaryValue' => @model.insured_value
        }
      end

      if @model.declared_value
        base['v11:PackageServiceOptions']['v11:DeclaredValue'] = {
          'v11:CurrencyCode' => 'USD',
          'v11:MonetaryValue' => @model.declared_value
        }
      end

      base
    end

    # Build a hash from a custom {Package package} which will be used by Savon.
    # A custom package requires specification of LWH dimensions.
    def custom_package
      base_package.tap do |package|
        package['v11:Dimensions'] = {
          'v11:UnitOfMeasurement' => {
            'v11:Code' => DIMENSION_UNITS[@model.dimension_units]
          },
          'v11:Length' => @model.length,
          'v11:Width'  => @model.width,
          'v11:Height' => @model.height,
          :order! => ['v11:UnitOfMeasurement', 'v11:Length', 'v11:Width', 'v11:Height']
        }
        package[:order!] = CUSTOM_PACKAGE_ORDER
      end
    end

    # Build a hash from a standard {Package package} which will be used by Savon.
    # A standard package requires no specification of LWH dimensions.
    def standard_package
      base_package.tap do |package| 
        package[:order!] = STANDARD_PACKAGE_ORDER
      end
    end

    def build
      @model.custom_package? ? custom_package : standard_package
    end
  end
end
