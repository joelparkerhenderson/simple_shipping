module SimpleShipping::Fedex
  # Builds a shipment element for FedEx SOAP service.
  class ShipmentBuilder < SimpleShipping::Abstract::Builder
    # Value for RateRequestTypes XML element.
    RATE_REQUEST_TYPE = 'ACCOUNT'

    # Number of packages.
    PACKAGE_COUNT = '1'

    # Mapping for package types
    PACKAGING_TYPES = {
      :box_10kg => 'FEDEX_10KG_BOX',
      :box_25kg => 'FEDEX_25KG_BOX',
      :box      => 'FEDEX_BOX',
      :envelope => 'FEDEX_ENVELOPE',
      :pak      => 'FEDEX_PAK',
      :tube     => 'FEDEX_TUBE',
      :your     => 'YOUR_PACKAGING'
    }

    # Mapping for service types
    SERVICE_TYPES = {
      :europe_first_international_priority => 'EUROPE_FIRST_INTERNATIONAL_PRIORITY',
      :fedex_1_day_freight                 => 'FEDEX_1_DAY_FREIGHT',
      :fedex_2_day_am                      => 'FEDEX_2_DAY',
      :fedex_2_day_freight                 => 'FEDEX_2_DAY_AM',
      :fedex_3_day_freight                 => 'FEDEX_2_DAY_FREIGHT',
      :fedex_3_day_freight                 => 'FEDEX_3_DAY_FREIGHT',
      :fedex_express_saver                 => 'FEDEX_EXPRESS_SAVER',
      :fedex_freight_economy               => 'FEDEX_FIRST_FREIGHT',
      :fedex_freight_economy               => 'FEDEX_FREIGHT_ECONOMY',
      :fedex_freight_priority              => 'FEDEX_FREIGHT_PRIORITY',
      :fedex_ground                        => 'FEDEX_GROUND',
      :first_overnight                     => 'FIRST_OVERNIGHT',
      :ground_home_delivery                => 'GROUND_HOME_DELIVERY',
      :international_economy               => 'INTERNATIONAL_ECONOMY',
      :international_economy_freight       => 'INTERNATIONAL_ECONOMY_FREIGHT',
      :international_first                 => 'INTERNATIONAL_FIRST',
      :international_priority              => 'INTERNATIONAL_PRIORITY',
      :international_priority_freight      => 'INTERNATIONAL_PRIORITY_FREIGHT',
      :priority_overnight                  => 'PRIORITY_OVERNIGHT',
      :smart_post                          => 'SMART_POST',
      :standard_overnight                  => 'STANDARD_OVERNIGHT'
    }

    # Mapping for dropoff types.
    DROPOFF_TYPES = {
      :business_service_center => 'BUSINESS_SERVICE_CENTER',
      :drop_box                => 'DROP_BOX',
      :regular_pickup          => 'REGULAR_PICKUP',
      :request_courier         => 'REQUEST_COURIER',
      :station                 => 'STATION'
    }

    set_default_opts :dropoff_type => :business_service_center,
                     :service_type => :fedex_ground

    # Build the shipment representation as a hash for the Savon client.
    def build
      {'ShipTimestamp'             => ship_timestamp,
       'DropoffType'               => DROPOFF_TYPES[@opts[:dropoff_type]],
       'ServiceType'               => SERVICE_TYPES[@opts[:service_type]],
       'PackagingType'             => PACKAGING_TYPES[@model.package.packaging_type],
       'Shipper'                   => PartyBuilder.build(@model.shipper),
       'Recipient'                 => PartyBuilder.build(@model.recipient),
       'ShippingChargesPayment'    => shipping_charges_payment,
       'LabelSpecification'        => label_specification,
       'RateRequestTypes'          => RATE_REQUEST_TYPE,
       'PackageCount'              => PACKAGE_COUNT,
       'RequestedPackageLineItems' => PackageBuilder.build(@model.package),
       :order! => ['ShipTimestamp'   , 'DropoffType'    , 'ServiceType'           , 'PackagingType',
                   'Shipper'         , 'Recipient'      , 'ShippingChargesPayment', 'LabelSpecification',
                   'RateRequestTypes', 'PackageCount'   , 'RequestedPackageLineItems']
      }
    end

    # Perform validations.
    def validate
      validate_inclusion_of(:dropoff_type  , DROPOFF_TYPES)
      validate_inclusion_of(:service_type  , SERVICE_TYPES)
    end

    # Get the shipping timestamps in a specific format.
    #
    # @example
    #   ship_timestamp  # => "2014-01-08T14:41:53+02:00"
    #
    # @return [String]
    def ship_timestamp
      Time.new.strftime('%Y-%m-%dT%H:%M:%S%z').tap{|str| str[-2,0] = ':' }
    end
    private :ship_timestamp

    # Build the hash for the ShippingChargesPayment element.
    #
    # @return [Hash]
    def shipping_charges_payment
      {'PaymentType' => payment_type,
       'Payor'       => {'AccountNumber' => @model.payor_account_number},
       :order! => ['PaymentType', 'Payor']}
    end
    private :shipping_charges_payment

    # Get the payment type.
    #
    # @return [String]
    def payment_type
      (@model.payor == :shipper) ? 'SENDER' : 'RECIPIENT'
    end
    private :payment_type

    # Build the label parameters according to FedEx's API.
    #
    # @return [Hash]
    def label_specification
      { 'LabelFormatType' => 'COMMON2D',
        'ImageType'       => 'PNG',
        'LabelStockType'  => 'PAPER_4X6',
        :order!           => ['LabelFormatType', 'ImageType', 'LabelStockType'] }
    end
    private :label_specification
  end
end
