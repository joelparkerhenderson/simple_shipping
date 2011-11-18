module SimpleShipping
  module Base
    class RequestBuilder
      attr_reader :credentials

      def initialize(credentials)
	@credentials = credentials
      end
    end
  end
end
