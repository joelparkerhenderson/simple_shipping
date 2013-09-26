require 'spec_helper'

describe SimpleShipping::ValidationError do
  describe "to_s" do
    it "should create message with full messages from Abstract::Model argument" do
      TestModel = Class.new(SimpleShipping::Abstract::Model)
      model = TestModel.new

      errors = double('ActiveModel::Errors')
      full_messages = ["error one", "error two"]

      model.should_receive(:errors).and_return(errors)
      errors.should_receive(:full_messages).and_return(full_messages)

      error = SimpleShipping::ValidationError.new(model)
      error.to_s.should == "Invalid model TestModel. Validation errors: error one, error two"
    end

    it "should create message with given string" do
      test = "test string"
      error = SimpleShipping::ValidationError.new(test)
      error.to_s.should == test
    end
  end
end

describe SimpleShipping::ValidationError do
  describe "to_s" do
    it "should create message with SOAP 1.1 faultcode information" do
      fault = Hash.new
      fault[:faultcode] = "faultcode"
      fault[:faultstring] = "faultstring"

      fault[:detail] = {
        :errors => {
          :error_detail => {
            :primary_error_code => {
              :description => "description"
            }
          }
        }
      }

      error = SimpleShipping::RequestError.new(:fault => fault)
      error.to_s.should == "faultstring description"
    end

    it "should create message with SOAP 1.2 faultcode information" do
      fault = Hash.new
      fault[:code] = {:value => "value"}
      fault[:reason] = {:text => "reason"}

      error = SimpleShipping::RequestError.new(:fault => fault)
      error.to_s.should == "(value) reason"
    end
  end
end
