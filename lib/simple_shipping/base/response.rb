class SimpleShipping::Base::Response
  class NoLabelError < Exception; end

  attr_reader :response
  class_attribute :label_image_path

  def initialize(savon_resp)
    @response = savon_resp    
  end

  def save_label(file_path)
    File.open(file_path, 'w'){|f| f.write(label_image) }
  end

  def label_image
    raise NoLabelError unless label_image_base64
    label_image_base64.unpack('m').first
  end

  def label_image_base64
    @response.to_array(*label_image_path).first
  end
end
