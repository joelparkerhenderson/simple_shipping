module SimpleShipping
  # Base class for request builders. Every service has its own implementation.
  class Abstract::Request
    attr_reader :credentials
    attr_reader :type

    def initialize(credentials)
      @credentials = credentials
    end

    # Wrap the Savon response with specific response for shipment provider.
    #
    # @param savon_response [Savon::Response]
    #
    # @return [SimpleShipping::Abstract::Response]
    def response(savon_response)
      response_class.new(savon_response)
    end

    # Response class to wrap Savon response.
    #
    # @return [Class]
    def response_class
      Response
    end
  end
end
