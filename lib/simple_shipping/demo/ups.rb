class SimpleShipping::Demo::Ups < SimpleShipping::Demo::Base
  def package
    @package ||= SimpleShipping::Package.new(
        :weight         => 0.5,
        :packaging_type => :envelope
    )
  end

  def ship_client
    @ship_client ||= SimpleShipping::Ups::ShipClient.new(
        :credentials => options.slice(:username, :password, :access_license_number),
        :log         => options[:log]
    )
  end

  def void_client
    @void_client ||= SimpleShipping::Ups::VoidClient.new(
        :credentials => options.slice(:username, :password, :access_license_number),
        :log         => options[:log],
        :live        => options[:live]
    )
  end

  def shipment_identification_number
    @shipment_identification_number ||= '1234567890'
  end

  attr_reader :credentials

  def initialize(options = {})
    @options = options.reverse_merge(
        :log          => false,
        :service_type => :second_day_air
    )
  end

  def shipment_request
    ship_client.shipment_request(shipper, recipient, package, :service_type => options[:service_type])
  end

  def void_request
    void_client.void_request(shipment_identification_number)
  end

end
