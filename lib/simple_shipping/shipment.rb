module SimpleShipping
  # Represents a shipment.
  #
  # == Attributes:
  # * _shipper_ (an instance of {SimpleShipping::Party}
  # * _recipient_ (an instance of {SimpleShipping::Party}
  # * _package_ (an instance of {SimpleShipping::Package}
  # * _payor_  (:shipper, :recipient). Default value is :shipper
  class Shipment < Abstract::Model
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

    # Account number of payor.
    def payor_account_number
      case payor
      when :shipper
        shipper.account_number if shipper.respond_to?(:account_number)
      when :recipient
        recipient.account_number if recipient.respond_to?(:account_number)
      end
    end

    # Validate presence of payor account number.
    #
    # @return [void]
    def validate_payor_account_number
      errors.add(:abstract, "Payor account number is missing") unless payor_account_number
    end
    private :validate_payor_account_number
  end
end
