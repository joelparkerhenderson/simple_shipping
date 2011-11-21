require 'spec_helper'

describe SimpleShipping::Contact do
  it { should be_kind_of SimpleShipping::Abstract::Model }

  describe 'attributes' do
    it { should have_attribute :person_name }
    it { should have_attribute :company_name }
    it { should have_attribute :phone_number }
    it { should have_attribute :email }
  end

  describe 'validations' do
    it {should validate_presence_of :phone_number }

    it 'person_name or company_name should be present' do
      contact = SimpleShipping::Contact.new(:phone_number => '123')
      contact.should_not be_valid

      contact.person_name = "John"
      contact.should be_valid

      contact.person_name = nil
      contact.company_name = "Osborn Inc"
      contact.should be_valid
    end
  end
end
