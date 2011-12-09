# A wrapper for UPS response
class SimpleShipping::Ups::Response < SimpleShipping::Abstract::Response
  self.label_image_path = [:shipment_response, :shipment_results, :package_results, :shipping_label, :graphic_image]
end
