shared_examples_for "builders" do 
  it { should be_kind_of SimpleShipping::Abstract::Builder }
  it { should respond_to :build }
  it { should respond_to :validate }

  it "should respond to .build" do
    subject.class.should respond_to :build
  end
end
