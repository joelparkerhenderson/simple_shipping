# Represents a response returned by remote service for request initiated
# by {SimpleShipping::Abstract::Client client}.
#
# It's kind of an abstract class which provides a common interface. In real world you have deal with its subclasses:
# * {SimpleShipping::Fedex::Response}
# * {SimpleShipping::Ups::Response}
#
# == Example:
#   response = client.request(shipper, recipient, package)  
#   response.response # => #<Savon::SOAP::Response ...>
#
#   # get the label as abstract64 encoded data
#   response.label_image_base64 # => "odGqk/KmgLaawV..."
#
#   # Save the label as an image.
#   # You can use any extension supported by RMagick.
#   response.save_label("./label.png")
#   response.save_label("./label.gif")
#   response.save_label("./label.jpg")
class SimpleShipping::Abstract::Response
  attr_reader :response
  class_attribute :label_image_path

  def initialize(savon_resp = nil)
    @response = savon_resp    
  end

  def save_label(file_path)
    img = Magick::Image.read_inline(label_image_base64).first
    img.write(file_path)
  end

  def label_image_base64
    @response.to_array(*label_image_path).first
  end
end
