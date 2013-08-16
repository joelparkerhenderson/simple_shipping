class SimpleShipping::Demo::Fedex < SimpleShipping::Demo::Base
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

  def fedex_client
    @fedex_client ||= SimpleShipping::Fedex::Client.new(
        :credentials => options.slice(:key, :password, :account_number, :meter_number),
        :log         => options[:log],
        :live        => options[:live]
    )
  end

  attr_reader :credentials

  def initialize(options = {})
    @options = options.reverse_merge(:log => false)
  end

  def shipment_request
    fedex_client.shipment_request(shipper, recipient, package)
  end
end
