class SimpleShipping::Shipment < SimpleShipping::Base::Model
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
    errors.add(:base, "Payor account number is missing") unless payor_account_number
  end
end
