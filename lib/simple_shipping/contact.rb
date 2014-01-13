module SimpleShipping
  # Represents the contact information of the {SimpleShipping::Party party} who takes
  # part in shipment process.
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

    # Validate presence of person or company name.
    def validate_name
      errors.add(:abstract, "person_name or company_name must be present") unless (person_name || company_name)
    end
  end
end
