describe Config do

  context 'context methods' do
    let(:config) { SpecFactory.config }

    it 'implements context?' do
      expect(config.context?('context1')).to be
      expect(config.context?('bogus_context')).not_to be
    end

    it 'implements get_context' do
      expect(config.get_context('context1')).to be_kind_of Context
      expect(config.get_context('context1').name).to eq 'context1'
      expect(config.get_context('bogus_context')).to be_nil
    end

    it 'implements environment?' do
      expect(config.environment?('production')).to be
      expect(config.environment?('bogus_environment')).not_to be
    end

    it 'implements get_environment' do
      expect(config.get_environment('production')).to be_kind_of Environment
      expect(config.get_environment('production').name).to eq 'production'
      expect(config.get_environment('bogus_environment')).to be_nil
    end

    it 'implements request?' do
      expect(config.request?('exampleRequest')).to be
      expect(config.request?('bogus_request')).not_to be
    end

    it 'implements get_request' do
      expect(config.get_request('exampleRequest')).to be_kind_of Request
      expect(config.get_request('exampleRequest').name).to eq 'exampleRequest'
      expect(config.get_request('bogus_request')).to be_nil
    end
  end

  #context 'variables method' do
    #it 'includes variables from environments in variables' do
      #env = Environment.new name: 'test',
                            #variables: {key1: 'val1'}
      #config = Config.new(environments: [env])
      #expect(config.variables).to have_key :key1
    #end
  #end
end
