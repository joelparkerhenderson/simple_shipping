# Abstract class which provides common interfaces for the next concrete clients:
# * {Fedex::Client}
# * {Ups::Client}
class SimpleShipping::Base::Client
  class_attribute :required_credetials, :wsdl_document, :builder_class

  def self.set_required_credetials(*args)
    self.required_credetials = args
  end

  def self.set_wsdl_document(wsdl_path)
    self.wsdl_document = wsdl_path
  end

  def initialize(credentials)
    validate_credetials(credentials)
    @credentials = OpenStruct.new(credentials)
    @client      = Savon::Client.new(wsdl_document)
  end

  def request(shipper, recipient, package, opts)
    raise "#request should be implemented"
  end


  private 

  def validate_credetials(credentials)
    credentials.assert_valid_keys(required_credetials)
    missing = required_credetials - credentials.keys
    raise(Error.new "The next credentials are missing for #{self}: #{missing.join(', ')}") unless missing.empty?
  end

  def create_shipment(shipper, recipient, package, opts = {})
    shipment = SimpleShipping::Shipment.new(:shipper   => shipper,
			                    :recipient => recipient,
			                    :package   => package)
    shipment.payor = opts[:payor] if opts[:payor]
    shipment
  end
end
