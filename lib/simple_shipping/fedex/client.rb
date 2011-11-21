module SimpleShipping::Fedex
  # Required credentials:
  # * _key_
  # * _password_
  # * _account_number_
  # * _meter_number_
  #
  # = Usage
  #  client = SimpleShipping::Fedex::Client.new(:key            => "KEY",
  #                                             :password       => "PASSWORD",
  #                                             :account_number => "ACCOUNT NUMBER",
  #                                             :METER_NUMBER   => "METER NUMBER")
  #  client.request(shipper, recipient, package) # => #<SimpleShipping::Fedex::Response ...>
  class Client < SimpleShipping::Abstract::Client
    set_required_credetials :key, :password, :account_number, :meter_number
    set_wsdl_document       File.join(SimpleShipping::WSDL_DIR, "fedex/ship_service_v10.wsdl")

    def request(shipper, recipient, package, opts = {})
      extra_opts = opts.delete(:extra_opts) || {}
      shipment = create_shipment(shipper, recipient, package, opts)

      builder = RequestBuilder.new(@credentials)
      savon_response = @client.request("ProcessShipmentRequest") do
        soap.body = builder.build_request(shipment, extra_opts)
      end
      Response.new(savon_response)
    end
  end
end
