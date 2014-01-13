module SimpleShipping
  # Represents a response returned by the remote service for a request initiated
  # by {SimpleShipping::Abstract::Client client}.
  #
  # An abstract class which provides a common interface.
  # In the real world, you will deal with its subclasses:
  # * {SimpleShipping::Fedex::Response}
  # * {SimpleShipping::Ups::Response}
  #
  # == Example:
  #   response = client.request(shipper, recipient, package)
  #   response.response # => #<Savon::SOAP::Response ...>
  class Abstract::Response
    attr_reader :response

    def initialize(savon_resp = nil)
      @response = savon_resp
    end

    # Fetch the value of an XML attribute at the path specified as an array.
    # of node names
    def value_of(*path)
      @response.to_array(*path).first
    end
  end
end
