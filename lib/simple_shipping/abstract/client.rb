# Abstract class which provides common interfaces for the next concrete clients:
# * {Fedex::Client}
# * {Ups::Client}
class SimpleShipping::Abstract::Client
  class_attribute :required_credentials, :wsdl_document, :builder_class

  # Sets credentials which should be validated.
  def self.set_required_credentials(*args)
    self.required_credentials = args
  end

  # Sets WSDL document used by Savon.
  def self.set_wsdl_document(wsdl_path)
    self.wsdl_document = wsdl_path
  end

  # Creates instance of a client.
  # == Parameters:
  #   * credentials - a hash with credentials.
  def initialize(credentials)
    validate_credentials(credentials)
    @credentials = OpenStruct.new(credentials)
    @client      = Savon::Client.new(wsdl_document)
  end

  # Sends request and returns kind of {SimpleShipping::Abstract::Response}
  # The method must be redefined by subclasses.
  def execute(shipper, recipient, package, opts)
    raise "#execute should be implemented"
  end


  private 

  # Validates all required credentials are passed.
  def validate_credentials(credentials)
    credentials.assert_valid_keys(required_credentials)
    missing = required_credentials - credentials.keys
    raise(Error.new "The next credentials are missing for #{self}: #{missing.join(', ')}") unless missing.empty?
  end

  # Builds {Shipment shipment} model
  def create_shipment(shipper, recipient, package, opts = {})
    shipment = SimpleShipping::Shipment.new(:shipper   => shipper,
                                            :recipient => recipient,
                                            :package   => package)
    shipment.payor = opts[:payor] if opts[:payor]
    shipment
  end
end
