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
      @options    = options.dup
      @live       = options.delete(:live)
      credentials = options.delete(:credentials)

      validate_credentials(credentials)
      @credentials = OpenStruct.new(credentials)

      @client = Savon.client(client_options(options))
    end

    # @param [Hash] options Savon client options
    # @return [Hash{Symbol => Object}] Savon client options
    def client_options(options = {})
      endpoint = @live ? self.class.production_address : self.class.testing_address

      options.symbolize_keys.reverse_merge(
        :wsdl     => wsdl_document,
        :endpoint => endpoint
      )
    end
    protected :client_options


    # Validates all required credentials are passed.
    def validate_credentials(credentials)
      credentials.assert_valid_keys(required_credentials)
      missing = required_credentials - credentials.keys
      raise(Error.new "The next credentials are missing for #{self}: #{missing.join(', ')}") unless missing.empty?
    end
    private :validate_credentials

    # Builds {Shipment shipment} model
    def create_shipment(shipper, recipient, package, opts = {})
      shipment = SimpleShipping::Shipment.new(
        :shipper   => shipper,
        :recipient => recipient,
        :package   => package)
      shipment.payor = opts[:payor] if opts[:payor]
      shipment
    end
    private :create_shipment

    def log_request(soap)
      log_soap("request", soap)
    end
    private :log_request

    def log_response(soap)
      log_soap("response", soap)
    end
    private :log_response

    def log_soap(name, soap)
      if @options[:debug]
        debug_path = @options.fetch(:debug_path, '.')
        path = File.join(debug_path, "#{name}.xml")
        File.open(path, 'w') {|f| f.write soap.to_xml}
      end
    end
    private :log_soap
  end
end
