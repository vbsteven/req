describe State do
  it_behaves_like 'VariableProvider'

  context 'variables' do
    it 'returns variables from environment' do
      env = Environment.new name: 'env', variables: { key1: 'val1' }
      state = State.new environment: env

      expect(state.variables).to have_key :key1
      expect(state.variables[:key1]).to eq 'val1'
    end

    it 'returns variables from context' do
      ctx = Context.new name: 'ctx', variables: { key1: 'val1' }
      state = State.new context: ctx

      expect(state.variables).to have_key :key1
      expect(state.variables[:key1]).to eq 'val1'
    end

    it 'returns variables from custom_variables' do
      state = State.new custom_variables: { key1: 'val1' }

      expect(state.variables).to have_key :key1
      expect(state.variables[:key1]).to eq 'val1'
    end

    it 'custom_variables get priority' do
      state = State.new custom_variables: { key: 'custom' },
                        environment: Environment.new(variables: { key: 'env' }),
                        context: Context.new(variables: { key: 'ctx' })

      expect(state.variables[:key]).to eq 'custom'
    end

    it 'without custom variables, context gets priority' do
      state = State.new custom_variables: {},
                        environment: Environment.new(variables: { key: 'env' }),
                        context: Context.new(variables: { key: 'ctx' })

      expect(state.variables[:key]).to eq 'ctx'
    end

  end

end
