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
    class Client < SimpleShipping::Abstract::Client
      set_required_credentials :username, :password, :access_license_number
      set_wsdl_document       File.join(SimpleShipping::WSDL_DIR, "ups/Ship-testing.wsdl")

      def shipment_request(shipper, recipient, package, opts = {})
        shipment = create_shipment(shipper, recipient, package, opts)
        request =  ShipmentRequest.new(@credentials, shipment)
        execute(request)
      end

      def ship_confirm_request(shipper, recipient, package, opts = {})
        shipment = create_shipment(shipper, recipient, package, opts)
        request =  ShipConfirmRequest.new(@credentials, shipment)
        execute(request)
      end

      # Performs ShipmentRequest to UPS service.
      # TODO: refactor. {Ups::Client#request} and {Fedex::Client#request} are quite similar
      def execute(request)
        savon_response = @client.request(request.type) do
          soap.namespaces['xmlns:v1']  = "http://www.ups.com/XMLSchema/XOLTWS/UPSS/v1.0"
          soap.namespaces['xmlns:v11'] = "http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0"
          soap.namespaces['xmlns:v12'] = "http://www.ups.com/XMLSchema/XOLTWS/Common/v1.0"
          soap.header = request.header
          soap.body   = request.body
        end

        request.response(savon_response)
      rescue Savon::SOAP::Fault => e
        raise RequestError.new(e)
      end
      private :execute
    end
  end
end
