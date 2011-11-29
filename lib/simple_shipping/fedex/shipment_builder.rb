module SimpleShipping
  module Fedex
    class ShipmentBuilder < SimpleShipping::Abstract::Builder
      RATE_REQUEST_TYPE = 'ACCOUNT'
      PACKAGE_COUNT = '1'

      # Package types mapping
      PACKAGING_TYPES = {
        :box_10kg => 'FEDEX_10KG_BOX',
        :box_25kg => 'FEDEX_25KG_BOX',
        :box      => 'FEDEX_BOX',
        :envelope => 'FEDEX_ENVELOPE',
        :pak      => 'FEDEX_PAK',
        :tube     => 'FEDEX_TUBE',
        :your     => 'YOUR_PACKAGING'
      }

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

      DROPOFF_TYPES = {
        :business_service_center => 'BUSINESS_SERVICE_CENTER',
        :drop_box                => 'DROP_BOX',
        :regular_pickup          => 'REGULAR_PICKUP',
        :request_courier         => 'REQUEST_COURIER',
        :station                 => 'STATION'
      }

      set_default_opts :dropoff_type   => :business_service_center,
                       :service_type   => :fedex_ground

      def build
        {'ShipTimestamp'             => build_ship_timestamp,
         'DropoffType'               => DROPOFF_TYPES[@opts[:dropoff_type]],
         'ServiceType'               => SERVICE_TYPES[@opts[:service_type]],
         'PackagingType'             => PACKAGING_TYPES[@model.package.packaging_type],
         'Shipper'                   => PartyBuilder.build(@model.shipper),
         'Recipient'                 => PartyBuilder.build(@model.recipient),
         'ShippingChargesPayment'    => build_shipping_charges_payment,
         'LabelSpecification'        => build_label_speicfication,
         'RateRequestTypes'          => RATE_REQUEST_TYPE,
         'PackageCount'              => PACKAGE_COUNT,
         'RequestedPackageLineItems' => PackageBuilder.build(@model.package),
         :order! => ['ins0:ShipTimestamp', 'ins0:DropoffType'           , 'ins0:ServiceType'       , 'ins0:PackagingType'   , 'ins0:Shipper',
                     'ins0:Recipient'    , 'ins0:ShippingChargesPayment', 'ins0:LabelSpecification', 'ins0:RateRequestTypes', 'ins0:PackageCount',
                     'ins0:RequestedPackageLineItems']
        }
      end

      def validate
        validate_inclusion_of(:dropoff_type  , DROPOFF_TYPES)
        validate_inclusion_of(:service_type  , SERVICE_TYPES)
      end


      private

      def build_ship_timestamp
        Time.new.strftime('%Y-%m-%dT%H:%M:%S%z').tap{|str| str[-2,0] = ':' }
      end

      def build_shipping_charges_payment
        {'PaymentType' => payment_type,
         'Payor'       => {'AccountNumber' => @model.payor_account_number},
         :order! => ['ins0:PaymentType', 'ins0:Payor']}
      end

      def payment_type
        (@model.payor == :shipper) ? 'SENDER' : 'RECIPIENT'
      end

      def build_label_speicfication
        { 'LabelFormatType' => 'COMMON2D',
          'ImageType'       => 'PNG',
          'LabelStockType'  => 'PAPER_4X6',
          :order! => ['ins0:LabelFormatType', 'ins0:ImageType', 'ins0:LabelStockType'] }
      end
    end
  end
end
