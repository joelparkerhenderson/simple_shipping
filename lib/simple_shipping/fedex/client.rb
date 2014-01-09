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
    set_required_credentials :key, :password, :account_number, :meter_number

    set_wsdl_document       File.join(SimpleShipping::WSDL_DIR, "fedex/ship_service_v10.wsdl")
    set_testing_address     "https://wsbeta.fedex.com:443/web-services/ship"
    set_production_address  "https://wsbeta.fedex.com:443/web-services/ship" # Not configured

    # Send shipment request to Fedex.
    def shipment_request(shipper, recipient, package, opts = {})
      shipment = create_shipment(shipper, recipient, package, opts)
      request = ShipmentRequest.new(@credentials, shipment)
      execute(request)
    end

    # Send shipment confirmation request.
    def ship_confirm_request(shipper, recipient, package, opts = {})
      fail "Not Implemented"
    end

    # Send ProcessShipmentRequest request to the Fedex service and return
    # response wrapped in {Fedex::Response} object.
    def execute(request)
      savon_response = @client.call(request.type, :message => request.body)
      request.response(savon_response)
    end
    private :execute
  end
end
