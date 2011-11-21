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
#   response.label_image_abstract64 # => "odGqk/KmgLaawV..."
#
#   # get the label as binary data
#   response.label_image # => "\221,^-\036\277\024..."
#
#   # save the label as a file
#   response.save_label("path/to/file")
class SimpleShipping::Abstract::Response
  attr_reader :response
  class_attribute :label_image_path

  def initialize(savon_resp)
    @response = savon_resp    
  end

  def save_label(file_path)
    File.open(file_path, 'w'){|f| f.write(label_image) }
  end

  def label_image
    raise NoLabelError unless label_image_abstract64
    label_image_abstract64.unpack('m').first
  end

  def label_image_abstract64
    @response.to_array(*label_image_path).first
  end
end
