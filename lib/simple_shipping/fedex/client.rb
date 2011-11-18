module SimpleShipping::Fedex
  class Client < SimpleShipping::Base::Client
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
