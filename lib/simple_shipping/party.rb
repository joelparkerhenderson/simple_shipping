class SimpleShipping::Party < SimpleShipping::Base::Model
  attr_accessor :contact,
                :address,
		:account_number

  validates_presence_of :contact, :address
  validate :validate_submodels

  def validate_submodels
    errors.add(:contact, "contact is invalid") if contact && !contact.valid?
    errors.add(:address, "address is invalid") if address && !address.valid?
  end
end
