describe ConfigFactory do
  context 'load from YAML' do
    it 'correctly parses YAML input string into Config' do
      yaml = File.read('spec/Reqfile.example')
      config = ConfigFactory.build_from_yaml(yaml)

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
end
