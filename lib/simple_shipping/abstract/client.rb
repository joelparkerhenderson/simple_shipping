module SimpleShipping
  # Abstract class which provides common interfaces for the next concrete clients:
  # * {Fedex::Client}
  # * {Ups::Client}
  class Abstract::Client
    class_attribute :required_credentials,
                    :wsdl_document,
                    :production_address,
                    :testing_address

    # Sets credentials which should be validated.
    def self.set_required_credentials(*args)
      self.required_credentials = args
    end

    # Sets WSDL document used by Savon.
    def self.set_wsdl_document(wsdl_path)
      self.wsdl_document = wsdl_path
    end

    def self.set_production_address(address)
      self.production_address = address
    end

    def self.set_testing_address(address)
      self.testing_address = address
    end

    # Creates instance of a client.
    # == Parameters:
    #   * credentials - a hash with credentials.
    def initialize(options)
      credentials = options.dup
      live = credentials.delete(:live)

      validate_credentials(credentials)
      @credentials = OpenStruct.new(credentials)
      @client      = Savon::Client.new(wsdl_document)
      @client.wsdl.endpoint = options[:live] ? self.class.production_address : self.class.testing_address
    end

    # Validates all required credentials are passed.
    def validate_credentials(credentials)
      credentials.assert_valid_keys(required_credentials)
      missing = required_credentials - credentials.keys
      raise(Error.new "The next credentials are missing for #{self}: #{missing.join(', ')}") unless missing.empty?
    end
    private :validate_credentials

    # Builds {Shipment shipment} model
    def create_shipment(shipper, recipient, package, opts = {})
      shipment = SimpleShipping::Shipment.new(:shipper   => shipper,
                                              :recipient => recipient,
                                              :package   => package)
      shipment.payor = opts[:payor] if opts[:payor]
      shipment
    end
    private :create_shipment
  end
end
