module SimpleShipping
  module Abstract
    class RequestBuilder
      attr_reader :credentials

      def initialize(credentials)
	@credentials = credentials
      end
    end
  end
end
