# A wrapper for UPS ShipmentResponse
module SimpleShipping::Ups
  class ShipmentResponse < Response
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
  end
end
