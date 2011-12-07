module SimpleShipping
  module CustomMatchers
    class ValidatePresenceOfMatcher < BasicMatcher
      def initialize(attribute)
        @attribute = attribute.to_sym
      end
      
      def matches?(model)
        model.send("#{@attribute}=", nil)
        model.valid?
        model.errors.messages[@attribute] and
        model.errors.messages[@attribute].include? "can't be blank"
      end

      def description
        "validate presence of #{@attribute.inspect}"
      end
    end

    def validate_presence_of(attr_name)
      ValidatePresenceOfMatcher.new(attr_name)
    end
  end
end
