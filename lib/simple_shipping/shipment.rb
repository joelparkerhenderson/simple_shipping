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

  validates_presence_of :shipper, :recipient, :package, :payor
  validates_inclusion_of :payor, :in => [:shipper, :recipient]
  validates_submodel :shipper  , :as => SimpleShipping::Party
  validates_submodel :recipient, :as => SimpleShipping::Party
  validates_submodel :package  , :as => SimpleShipping::Package
  validate :validate_payor_account_number

  def payor_account_number
    case payor
      when :shipper
        shipper.respond_to?(:account_number) && shipper.account_number
      when :recipient 
        recipient.respond_to?(:account_number) && recipient.account_number
    end
  end

  private

  def validate_payor_account_number
    errors.add(:abstract, "Payor account number is missing") unless payor_account_number
  end
end
