module SimpleShipping
  # Parent error for all SimpleShipping errors
  class Error < StandardError; end

  # Error raises when response does not contain a label
  class NoLabelError < Error ; end

  # Raises when some data is invalid or missing to build a request
  class ValidationError < Error
    def initialize(model_or_msg)
      @message = case model_or_msg
      when Abstract::Model
        "Invalid model #{model_or_msg.class}. Validation errors: #{model_or_msg.errors.full_messages.join(', ')}"
      when String
        model_or_msg
      end

      super(@message)
    end
  end

  class RequestError < Error
    def initialize(savon_fault)
      fault = savon_fault.to_hash[:fault]

      @message = 
        if fault[:faultcode] # SOAP 1.1 fault.
          detail = fault[:detail][:errors][:error_detail][:primary_error_code]
          "#{fault[:faultstring]} #{detail[:description]}"
        elsif fault[:code] # SOAP 1.2 fault.
          "(#{fault[:code][:value]}) #{fault[:reason][:text]}"
        end

      super(@message)
    end
  end
end
