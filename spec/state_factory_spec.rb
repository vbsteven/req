
describe StateFactory do
  def example_state
    StateFactory.build_from_yaml(
      SpecFactory.state_yaml_str,
      SpecFactory.config
    )
  end

  let(:state) { example_state }

  context 'build_from_yaml' do
    it 'has a full environment' do
      expect(state.environment).to be_kind_of Environment
      expect(state.environment.name).to eq 'production'
    end

    it 'has a full context' do
      expect(state.context).to be_kind_of Context
      expect(state.context.name).to eq 'context1'
    end

    it 'has a hash with custom variables' do
      expect(state.custom_variables).to be_kind_of Hash
    end

    it 'raises an exception when not deserialzing into a Hash' do
      expect { StateFactory.build_from_yaml 'invalid_yaml', SpecFactory.config }
        .to raise_error 'Invalid YAML'
    end
  end
end
