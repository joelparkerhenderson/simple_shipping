module SimpleShipping
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
  #   # Save label to Doc Store
  #   response.save_label_to_doc_store  # => key returned from doc store
  #
  #   # Save the label as an image.
  #   # You can use any extension supported by RMagick.
  #   response.save_label_to_disk("./label.png")
  class Abstract::Response
    attr_reader :response
    class_attribute :label_image_path

    def initialize(savon_resp = nil)
      @response = savon_resp    
    end

    # Saves label image on local disk
    def save_label_to_disk(file_path)
      img = Magick::Image.read_inline(label_image_base64).first
      img.write(file_path)
    end

    # Saves label to DocStore and returns a key
    def save_label_to_doc_store
      label = DocStore::Label.new(:content_base64 => label_image_base64)
      label.save
      label.id
    rescue Errno::ECONNREFUSED
    end

    def label_image_base64
      @response.to_array(*label_image_path).first
    end
  end
end
