module SimpleShipping
  module CustomMatchers
    class BasicMatcher
      def failure_message
        "expected to #{description}"
      end

      def negative_failure_message
        "expected to not #{description}"
      end
    end
  end
end
