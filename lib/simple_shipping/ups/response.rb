class SimpleShipping::Ups::Response < SimpleShipping::Abstract::Response
  def digest
    value_of(:shipment_results, :shipment_digest)
  end
  # Fetches the value of an XML attribute at the path specified as an array
  # of node names
  def value_of(*path)
    super path.unshift(name_token)
  end

  def name_token
    self.class.name.split('::').last.underscore.to_sym
  end
  private :name_token
end
