describe 'Config class' do
  context 'load from hash' do
    let(:config) { Config.new({
      contexts: [{name: 'context1', vars: {key: 'value'}}],
      environments: [{name: 'production', endpoint: 'http://localhost/', vars: {}}],
      routes: [],
    })}

    it 'loads contexts from hash' do
      expect(config.contexts).to be_kind_of Array
      expect(config.contexts.first).to be_instance_of Context
      expect(config.contexts.first.name).to eq 'context1'
    end

    it 'loads environments from hash' do
      expect(config.environments).to be
      expect(config.environments.first).to be_instance_of Environment
      expect(config.environments.first.name).to eq 'production'
    end

    it 'loads requests from hash' do
      expect(config.requests).to be
    end
  end

  context 'load from YAML' do
    it 'correctly parses YAML input string into Config' do
      yaml = File.read('spec/Reqfile.example')
      config = Config.create_from_yaml(yaml)

      expect(config).to be_kind_of Config
      expect(config.contexts).to be_kind_of Array
      expect(config.contexts.count).to eq 2
      expect(config.contexts.first).to be_kind_of Context
      expect(config.contexts.first.name).to eq 'context1'

      expect(config.environments).to be_kind_of Array
      expect(config.environments.count).to eq 3
      expect(config.environments.first).to be_kind_of Environment
      expect(config.environments.first.name).to eq 'production'

      expect(config.requests).to be_kind_of Array
      expect(config.requests.count).to eq 1
      expect(config.requests.first).to be_kind_of Request
      expect(config.requests.first.name).to eq 'exampleRequest'
    end
  end

  context 'context methods' do
    let(:config) { Config.create_from_yaml(File.read('spec/Reqfile.example')) }

    it 'implements has_context?' do
      expect(config.has_context?('context1')).to be
      expect(config.has_context?('bogus_context')).not_to be
    end

    it 'implements get_context' do
      expect(config.get_context('context1')).to be_kind_of Context
      expect(config.get_context('context1').name).to eq 'context1'
      expect(config.get_context('bogus_context')).to be_nil 
    end

    it 'implements has_environment?' do
      expect(config.has_environment?('production')).to be
      expect(config.has_environment?('bogus_environment')).not_to be
    end

    it 'implements get_environment' do
      expect(config.get_environment('production')).to be_kind_of Environment
      expect(config.get_environment('production').name).to eq 'production'
      expect(config.get_environment('bogus_environment')).to be_nil 
    end

    it 'implements has_request?' do
      expect(config.has_request?('exampleRequest')).to be
      expect(config.has_request?('bogus_request')).not_to be
    end

    it 'implements get_request' do
      expect(config.get_request('exampleRequest')).to be_kind_of Request
      expect(config.get_request('exampleRequest').name).to eq 'exampleRequest'
      expect(config.get_request('bogus_request')).to be_nil 
    end
  end
end
