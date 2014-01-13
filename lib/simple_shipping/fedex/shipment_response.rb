module SimpleShipping::Fedex
  # A wrapper for UPS ShipmentResponse.
  class ShipmentResponse < Response
    # Get the label as abstract64 encoded data
    #   response.label_image_base64 # => "odGqk/KmgLaawV..."
    # This can be used directly in an HTML image tag with
    #   src="data:image/gif;base64,..."
    def label_image_base64
      value_of(:process_shipment_reply, :completed_shipment_detail, :completed_package_details, :label, :parts, :image)
    end
  end
end
