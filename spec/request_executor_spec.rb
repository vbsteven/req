describe 'RequestExecutor' do
  req = Req.create_with_config(Config.create_from_yaml(File.read('spec/Reqfile.example')))
  req.environment('production')
  req.context('context1')
  req.variable('custom_variable', 'custom_value')

  context 'with example request' do
    let(:executor) { RequestExecutor.new 'exampleRequest', req.config, req.state }

    it 'combines variables from environment, context and overrides' do
      expect(executor.merged_variables.keys).to include('app_id')
      expect(executor.merged_variables.keys).to include('user_id')
      expect(executor.merged_variables.keys).to include('custom_variable')
    end
  end
end
