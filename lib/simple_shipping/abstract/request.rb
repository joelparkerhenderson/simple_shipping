module SimpleShipping
  # Base class for request builders. Every service has its own implementation.
  class Abstract::Request
    attr_reader :credentials
    attr_reader :type

    def initialize(credentials)
      @credentials = credentials
    end

    def response(savon_response)
      response_class.new(savon_response)
    end

    def response_class
      Response
    end
  end
end
