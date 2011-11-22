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
  validates_submodel :address, :as => SimpleShipping::Address
  validates_submodel :contact, :as => SimpleShipping::Contact
end
