# A wrapper for UPS response
module SimpleShipping::Ups
  class ShipAcceptResponse < Response
    # Get the label as abstract64 encoded data
    #   response.label_image_base64 # => "odGqk/KmgLaawV..."
    # This can be used directly in an HTML image tag with
    #   src="data:image/gif;base64,..."
    def label_image_base64
      value_of(:shipment_results, :package_results, :shipping_label, :graphic_image)
    end

    def label_html
      Base64.decode64 value_of(:shipment_results, :package_results, :shipping_label, :html_image)
    end

    def receipt_html
      Base64.decode64 value_of(:shipment_results, :control_log_receipt, :graphic_image)
    end

    def tracking_number
      value_of(:shipment_results, :package_results, :tracking_number)
    end
  end
end
