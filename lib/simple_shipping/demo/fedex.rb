# Helper object to send demo requests to FedEx in order to test credentials
# and the library.
#
# @example
#   demo     = SimpleShipping::Demo::Fedex.new(credentials)
#   response = demo.shipment_request
class SimpleShipping::Demo::Fedex < SimpleShipping::Demo::Base
  attr_reader :credentials

  def initialize(options = {})
    @options = options.reverse_merge(:log => false)
  end

  # Build package object.
  #
  # @return [SimpleShipping::Package]
  def package
    @package ||= SimpleShipping::Package.new(
        :weight          => 1,
        :length          => 2,
        :height          => 3,
        :dimension_units => :in,  # you can use :kg as well
        :weight_units    => :lb,  # you can use :cm as well
        :width           => 4,
        :packaging_type  => :your
    )
  end

  # Initialize FedEx client.
  #
  # @return [SimpleShipping::Fedex::Client]
  def fedex_client
    @fedex_client ||= SimpleShipping::Fedex::Client.new(
        :credentials => options.slice(:key, :password, :account_number, :meter_number),
        :log         => options[:log],
        :live        => options[:live]
    )
  end

  # Send shipment request to FedEx.
  #
  # @return [SimpleShipping::Fedex::Response]
  def shipment_request
    fedex_client.shipment_request(shipper, recipient, package)
  end
end
