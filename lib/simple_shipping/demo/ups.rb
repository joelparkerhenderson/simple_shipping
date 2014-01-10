# Helper object to send demo requests to UPS in order to test credentials
# and the library.
#
# @example
#   demo = SimpleShipping::Demo::Ups.new(credentials)
#   response = demo.shipment_request
class SimpleShipping::Demo::Ups < SimpleShipping::Demo::Base
  attr_reader :credentials

  def initialize(options = {})
    @options = options.reverse_merge(
        :log          => false,
        :service_type => :second_day_air
    )
  end

  # Build package object.
  #
  # @return [SimpleShipping::Package]
  def package
    @package ||= SimpleShipping::Package.new(
        :weight         => 0.5,
        :packaging_type => :envelope
    )
  end

  # Initialize UPS client for shipment requests.
  #
  # @return [SimpleShipping::Ups::ShipClient]
  def ship_client
    @ship_client ||= SimpleShipping::Ups::ShipClient.new(
        :credentials => options.slice(:username, :password, :access_license_number),
        :log         => options[:log]
    )
  end

  # Initialize UPS client for void requests.
  #
  # @return [SimpleShipping::Ups::VoidClient]
  def void_client
    @void_client ||= SimpleShipping::Ups::VoidClient.new(
        :credentials => options.slice(:username, :password, :access_license_number),
        :log         => options[:log],
        :live        => options[:live]
    )
  end

  # Shipment Id. The number is picked randomly.
  #
  # @return [String]
  def shipment_identification_number
    @shipment_identification_number ||= '1234567890'
  end

  # Send a shipment request.
  #
  # @return [ShipClient::Ups::ShipmentResponse]
  def shipment_request
    ship_client.shipment_request(shipper, recipient, package, :service_type => options[:service_type])
  end

  # Send a request to void a shipment.
  #
  # @return [ShipClient::Ups::VoidResponse]
  def void_request
    void_client.void_request(shipment_identification_number)
  end
end
