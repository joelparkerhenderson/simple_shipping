# Party is a person or company who takes a part in shipment process.
# Party is used to represent a shipper or a recipient.
#
# == Attributes
# * _contact_ (instance of {SimpleShipping::Contact})
# * _address_ (instance of {SimpleShipping::Address})
# * _account_number_ (optional, but in some cases required)
#
# If one of attributes is missed an appropriate exception will be raised
# when you build a request.
class SimpleShipping::Party < SimpleShipping::Abstract::Model
  attr_accessor :contact,
                :address,
		:account_number

  validates_presence_of :contact, :address
  validate :validate_contact, :validate_address

  def validate_contact
    if !address.instance_of?(SimpleShipping::Address)
      errors.add(:address, "must be an instance of SimpleShipping::Address") 
    elsif address.invalid?
      errors.add(:address, "is invalid")
    end
  end

  def validate_address
    if !contact.instance_of?(SimpleShipping::Contact)
      errors.add(:contact, "must be an instance of SimpleShipping::Contact") 
    elsif contact.invalid?
      errors.add(:contact, "is invalid")
    end
  end
end
