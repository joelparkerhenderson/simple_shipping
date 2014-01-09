# Namespace for demo rake tasks used to test real remote requests by sending
# test requests to verify credentials. Not intended for runtime use.
class SimpleShipping::Demo
  extend ActiveSupport::Autoload

  attr_reader :options

  autoload :Fedex
  autoload :Ups


  # :nodoc:
  def shipper_address
    @shipper_address ||= SimpleShipping::Address.new(
        :country_code => 'US',
        :state_code   => 'TX',
        :city         => 'Texas',
        :street_line  => 'SN2000 Test Meter 8',
        :postal_code  => '73301'
    )
  end

  # :nodoc:
  def shipper_contact
    @shipper_contact ||= SimpleShipping::Contact.new(
        :person_name  => 'Mister Someone',
        :phone_number => '1234567890'
    )
  end

  # :nodoc:
  def shipper
    @shipper ||= SimpleShipping::Party.new(
        :address => shipper_address,
        :contact => shipper_contact,
        :account_number => options[:account_number]
    )
  end


  # :nodoc:
  def recipient_address
    @recipient_address ||= SimpleShipping::Address.new(
        :country_code => 'US',
        :state_code   => 'MN',
        :city         => 'Minneapolis',
        :street_line  => 'Nightmare Avenue 13',
        :postal_code  => '55411'
    )
  end

  # :nodoc:
  def recipient_contact
    @recipient_contact ||= SimpleShipping::Contact.new(
      :person_name  => "John Recipient Smith",
      :phone_number => "1234567890"
  )
  end

  # :nodoc:
  def recipient
    @recipient ||= SimpleShipping::Party.new(
      :address        => recipient_address,
      :contact        => recipient_contact
  )
  end

  # Overrides options with environment variables.
  def override_options_from_env
    keys = options.keys.map(&:to_s)
    overrides = ENV.to_hash.slice(*keys).symbolize_keys
    options.merge!(overrides)
  end
end
