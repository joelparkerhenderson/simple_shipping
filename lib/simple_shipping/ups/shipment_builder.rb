module SimpleShipping::Ups
  class ShipmentBuilder < SimpleShipping::Abstract::Builder
    PAYMENT_TYPE = '01' # 01 - Transportation, 02 - Duties and Taxes

    # service codes in UPS terminology 
    SERVICE_TYPES = {:next_day_air            => '01',
		     :second_day_air          => '02',
		     :ground                  => '03',
		     :express                 => '07',
		     :expedited               => '08',
		     :standard                => '11',
		     :three_day_select        => '12',
		     :next_day_air_saver      => '13',
		     :next_day_air_early_am   => '14',
		     :express_plus            => '54',
		     :second_day_air_am       => '59',
		     :saver                   => '65',
		     :today_standard          => '82',
		     :today_dedicated_courier => '83',
		     :today_intercity         => '84',
		     :today_express           => '85',
		     :today_express_saver     => '86'}

    set_default_opts :service_type => :ground

    def build
      { 'v11:Shipper'            => PartyBuilder.build(@model.shipper, :shipper => true),
	'v11:ShipTo'             => PartyBuilder.build(@model.recipient),
	'v11:PaymentInformation' => build_payment_info,
	'v11:Service'            => build_service,
	'v11:Package'            => PackageBuilder.build(@model.package),
	:order! => ['v11:Shipper', 'v11:ShipTo', 'v11:PaymentInformation', 'v11:Service', 'v11:Package'] } end

    def build_payment_info
      {'v11:ShipmentCharge' => build_simpment_charge }
    end

    def build_simpment_charge
      result = {'v11:Type' => PAYMENT_TYPE, :order! => ['v11:Type']}
      if @model.payor == :shipper
	result['v11:BillShipper'] = {'v11:AccountNumber' => @model.shipper.account_number}
	result[:order!] << 'v11:BillShipper'
      elsif @model.payor == :recipient
	result['v11:BillReceiver'] = {'v11:AccountNumber' => @model.recipient.account_number}
	result[:order!] << 'v11:BillReceiver'
      end
      result
    end

    def build_service
      {'v11:Code' => SERVICE_TYPES[@opts[:service_type]]}
    end

    def validate
      validate_inclusion_of(:service_type, SERVICE_TYPES)
    end
  end
end
