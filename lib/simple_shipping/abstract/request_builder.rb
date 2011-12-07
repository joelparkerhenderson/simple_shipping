module SimpleShipping
  module Abstract
    # Base class for request builders. Every service has its own implementation.
    class RequestBuilder
      attr_reader :credentials

      def initialize(credentials)
        @credentials = credentials
      end
    end
  end
end
