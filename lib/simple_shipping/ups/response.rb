class SimpleShipping::Ups::Response < SimpleShipping::Base::Response
  self.label_image_path = [:shipment_response, :shipment_results, :package_results, :shipping_label, :graphic_image]

  alias :save_label_as_gif :save_label
end
