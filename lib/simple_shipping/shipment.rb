# Represent a shipment
#
# == Attributes:
# * _shipper_ (an instance of {SimpleShipping::Party}
# * _recipient_ (an instance of {SimpleShipping::Party}
# * _package_ (an instance of {SimpleShipping::Package}
# * _payor_  (:shipper, :recipient). Default value is :shipper
class SimpleShipping::Shipment < SimpleShipping::Abstract::Model
  attr_accessor :shipper,
                :recipient,
		:package,
		:payor

  set_default_values :payor => :shipper

  validates_presence_of :shipper, :recipient, :package
  validates_inclusion_of :payor, :in => [:shipper, :recipient]
  validate :validate_payor_account_number

  def payor_account_number
    case payor
      when :shipper   then shipper.account_number
      when :recipient then recipient.account_number
    end
  end

  private

  def validate_payor_account_number
    errors.add(:abstract, "Payor account number is missing") unless payor_account_number
  end
end
