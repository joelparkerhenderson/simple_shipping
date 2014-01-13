module SimpleShipping::Ups
  # Abstract class for all UPS clients.
  # The problem with UPS is that its WSDL imports schemas. However schema imports are not supported
  # by Savon as by v.2.1.0. See: https://github.com/savonrb/wasabi/issues/1
  # Because of this we have to manually:
  #   1. Assign additional namespaces
  #   2. Switch to :qualified :elemen_form_default
  #     (to have all requests elements prepended with namespace
  #      if its namespace is not specified explicitly)
  #   3. Explicitly prepend namespace to all elements which not belong to WSDL target namespace
  #      i.e. UPSSecurity, Request/RequestOptions etc
  #
  class Client < SimpleShipping::Abstract::Client

    # @param [Hash] options Savon client options
    def client_options(options = {})
      super.deep_merge(
        :element_form_default => :qualified,
        :namespaces => {
          'xmlns:upss'   => "http://www.ups.com/XMLSchema/XOLTWS/UPSS/v1.0",
          'xmlns:common' => "http://www.ups.com/XMLSchema/XOLTWS/Common/v1.0",
        },
        :soap_header => soap_header
      )
    end
    protected :client_options

    # @return [Hash] of SOAP envelope header contents
    def soap_header
      {
        'upss:UPSSecurity' => {
          'upss:UsernameToken' => {
            'upss:Username' => @credentials.username,
            'upss:Password' => @credentials.password,
            :order!         => ['upss:Username', 'upss:Password']
          },
          'upss:ServiceAccessToken' => {
            'upss:AccessLicenseNumber' => @credentials.access_license_number
          },
          :order! => ['upss:UsernameToken', 'upss:ServiceAccessToken']
        }
      }
    end
    protected :soap_header
  end
end
