module SimpleShipping::Ups
  class Response < SimpleShipping::Abstract::Response
    def digest
      value_of(:shipment_results, :shipment_digest)
    end

    def shipment_identification_number
      value_of(:shipment_results, :shipment_identification_number)
    end

    # Fetches the value of an XML attribute at the path specified as an array
    # of node names but appends the implicit namespace on to the front of the
    # path
    def value_of(*path)
      super *path.unshift(name_token)
    end

    # All UPS requests are namespaced within the same name of the class by
    # convention
    def name_token
      self.class.name.split('::').last.underscore.to_sym
    end
    private :name_token
  end
end
