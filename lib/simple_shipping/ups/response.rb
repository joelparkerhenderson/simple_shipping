module SimpleShipping::Ups
  # Response from UPS.
  class Response < SimpleShipping::Abstract::Response
    # Digest what can be used to get a label.
    #
    # @return [String]
    def digest
      value_of(:shipment_results, :shipment_digest)
    end

    # Unique shipment ID returned by UPS.
    #
    # @return [Strig]
    def shipment_identification_number
      value_of(:shipment_results, :shipment_identification_number)
    end

    # Get package tracking number to look for delivery process on UPS site.
    #
    # @return [String] tracking number
    def tracking_number
      value_of(:shipment_results, :package_results, :tracking_number)
    end

    # Get the label as base64 encoded data
    #   response.label_image_base64 # => "odGqk/KmgLaawV..."
    # This can be used directly in an HTML image tag with
    #   src="data:image/gif;base64,..."
    def label_image_base64
      value_of(:shipment_results, :package_results, :shipping_label, :graphic_image)
    end

    # Label image.
    #
    # @return [String] binary
    def label_html
      value = value_of(:shipment_results, :package_results, :shipping_label, :html_image)
      Base64.decode64(value) if value
    end

    # Receipt.
    #
    # @return [String] binary
    def receipt_html
      value = value_of(:shipment_results, :control_log_receipt, :graphic_image)
      Base64.decode64(value) if value
    end

    # Fetches the value of an XML attribute at the path specified as an array
    # of node names but appends the implicit namespace on to the front of the
    # path
    def value_of(*path)
      super(*path.unshift(name_token))
    end

    # All UPS requests are namespaced within the same name of the class by
    # convention
    def name_token
      self.class.name.split('::').last.underscore.to_sym
    end
    private :name_token
  end
end
