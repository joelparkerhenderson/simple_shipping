class SimpleShipping::Fedex::Response < SimpleShipping::Abstract::Response
  self.label_image_path = [:process_shipment_reply, :completed_shipment_detail, :completed_package_details, :label, :parts, :image]

  alias :save_label_as_png :save_label
end
