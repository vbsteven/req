describe 'Environment' do
  context 'initialize' do
    let(:env) do
      Environment.new name: 'env',
                      endpoint: 'http://localhost/',
                      vars: { key: 'value' }
    end

    it 'extracts name from initializer hash' do
      expect(env.name).to eq 'env'
    end

    it 'extracts endpoint from initializer hash' do
      expect(env.endpoint).to eq 'http://localhost/'
    end

    it 'extract variables from initializer hash' do
      expect(env.variables).to be_kind_of Hash
      expect(env.variables.keys.first).to eq :key
      expect(env.variables[:key]).to eq 'value'
    end
  end
end
