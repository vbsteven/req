# VariableProvider is a ducktype for all classes that have a variables method
# that should return a hash of possible replacement variables
shared_examples_for 'VariableProvider' do
  it 'responds_to :variables' do
    expect(subject).to respond_to :variables
  end

  it 'returns a Hash from :variables' do
    expect(subject.variables).to be_kind_of Hash
  end
end

class VariableProviderDouble
  def variables
    {}
  end
end

describe VariableProviderDouble do
  it_behaves_like 'VariableProvider'
end
