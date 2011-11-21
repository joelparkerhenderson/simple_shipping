module SimpleShipping
  module Ups
    # Required credentials:
    # * _username_
    # * _password_
    # * _access_license_number_
    #
    # = Usage
    #  client = SimpleShipping::Fedex::Client.new(:username              => "USER NAME",
    #                                             :password              => "PASSWORD",
    #                                             :access_license_number => "LICENSE NUMBER")
    #  client.request(shipper, recipient, package) # => #<SimpleShipping::Ups::Response ...>
    class Client < SimpleShipping::Base::Client
      set_required_credetials :username, :password, :access_license_number
      set_wsdl_document       File.join(SimpleShipping::WSDL_DIR, "ups/Ship.wsdl")

      # TODO: refactor. {Ups::Client#request} and {Fedex::Client#request} are quite similar
      def request(shipper, recipient, package, opts = {})
        extra_opts = opts.delete(:extra_opts) || {}
        shipment = create_shipment(shipper, recipient, package, opts)

        builder =  RequestBuilder.new(@credentials)
        savon_response = @client.request("v11:ShipmentRequest") do
          soap.namespaces['xmlns:v1']  = "http://www.ups.com/XMLSchema/XOLTWS/UPSS/v1.0"
          soap.namespaces['xmlns:v11'] = "http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0"
          soap.namespaces['xmlns:v12'] = "http://www.ups.com/XMLSchema/XOLTWS/Common/v1.0"
          soap.header = builder.build_header
          soap.body   = builder.build_request(shipment, extra_opts)
        end
        Response.new(savon_response)
      end
    end
  end
end
