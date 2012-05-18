module SimpleShipping
  # Represents a contact information of {SimpleShipping::Party party} who takes 
  # a part in shipment process.
  #
  # == Attributes
  # * _person_name_ (optional if company_name is provided)
  # * _company_name_ (optional if person_name is provided)
  # * _phone_number_
  # * _email_ (optional)
  class Contact < Abstract::Model
    attr_accessor :person_name,
                  :company_name,
                  :phone_number,
                  :email

    validates_presence_of :phone_number
    validate :validate_name

    def validate_name
      errors.add(:abstract, "person_name or company_name must be present") unless (person_name || company_name)
    end
  end
end
