class SimpleShipping::Contact < SimpleShipping::Base::Model
  attr_accessor :person_name,
		:company_name,
                :phone_number,
		:email

  validates_presence_of :phone_number
  validate :validate_name

  def validate_name
    errors.add(:base, "person_name or company_name must be present") unless (person_name || company_name)
  end
end
