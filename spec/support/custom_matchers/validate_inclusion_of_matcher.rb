module SimpleShipping
  module CustomMatchers
    class ValidateInclusionOfMatcher < BasicMatcher
      def initialize(attribute)
	@attribute = attribute.to_sym
      end
      
      def matches?(model)
        @enumeration.each do |value|
          model.send("#{@attribute}=", value)
          return false if has_error?(model)
        end
        model.send("#{@attribute}=", "ANOTHER_VALUE_#{rand}")
        has_error?(model)
      end

      def in(*enumeration)
        @enumeration = enumeration
        self
      end

      def description
	"validate inclusion of #{@attribute.inspect} in #{@enumeration.inspect}"
      end

      def has_error?(model)
        model.valid?
	model.errors.messages[@attribute] and
	model.errors.messages[@attribute].include?("is not included in the list")
      end
    end

    def validate_inclusion_of(attr_name)
      ValidateInclusionOfMatcher.new(attr_name)
    end
  end
end
