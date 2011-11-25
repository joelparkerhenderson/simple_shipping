shared_examples_for "responses" do 
  it { should be_kind_of SimpleShipping::Abstract::Response }
  it { should respond_to :save_label }
  it { should respond_to :label_image_base64 }
  it { should respond_to :response }
end
