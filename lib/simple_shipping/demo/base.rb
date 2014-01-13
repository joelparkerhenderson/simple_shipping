# Base class for UPS and FedEx demos.
class SimpleShipping::Demo::Base
  attr_reader :options

  # Build the shipper address with random attributes.
  #
  # @return [SimpleShipping::Address]
  def shipper_address
    @shipper_address ||= SimpleShipping::Address.new(
        :country_code => 'US',
        :state_code   => 'TX',
        :city         => 'Texas',
        :street_line  => 'SN2000 Test Meter 8',
        :postal_code  => '73301'
    )
  end

  # Build the shipper contact object.
  #
  # @return [SimpleShipping::Contact]
  def shipper_contact
    @shipper_contact ||= SimpleShipping::Contact.new(
        :person_name  => 'Mister Someone',
        :phone_number => '1234567890'
    )
  end

  # Build the shipper object.
  #
  # @return [SimpleShipping::Party]
  def shipper
    @shipper ||= SimpleShipping::Party.new(
        :address => shipper_address,
        :contact => shipper_contact,
        :account_number => options[:account_number]
    )
  end

  # Build the recipient address with random attributes.
  #
  # @return [SimpleShipping::Address]
  def recipient_address
    @recipient_address ||= SimpleShipping::Address.new(
        :country_code => 'US',
        :state_code   => 'MN',
        :city         => 'Minneapolis',
        :street_line  => 'Nightmare Avenue 13',
        :postal_code  => '55411'
    )
  end

  # Build the recipient contact.
  #
  # @return [SimpleShipping::Contact]
  def recipient_contact
    @recipient_contact ||= SimpleShipping::Contact.new(
      :person_name  => "John Recipient Smith",
      :phone_number => "1234567890"
  )
  end

  # Build the recipient object.
  #
  # @return [SimpleShipping::Party]
  def recipient
    @recipient ||= SimpleShipping::Party.new(
      :address        => recipient_address,
      :contact        => recipient_contact
  )
  end
end
