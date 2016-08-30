describe 'RequestFactory' do
  context 'create' do
    config = SpecFactory.config
    state = SpecFactory.state
    state.custom_variables.store 'var', 'custom_value'
    state.custom_variables.store 'customvar', 'custom_value'
    request = config.requests.first
    request.headers['X-custom-1'] = '${environmentvar}'
    request.headers['X-custom-2'] = '${contextvar}'
    request.headers['X-custom-3'] = '${customvar}'

    req = RequestFactory.create(config, state, config.requests.first)

    it 'returns a PreparedRequest' do
      expect(req).to be_kind_of PreparedRequest
    end

    it 'contains headers from environment' do
      expect(req.headers.keys).to include 'X-req-environment'
    end

    it 'contains headers from context' do
      expect(req.headers.keys).to include 'X-req-context'
    end

    it 'contains headers from request' do
      expect(req.headers.keys).to include 'X-req-request'
    end

    it 'applies var interpolation to environment headers' do
      expect(req.headers['X-req-environment-var']).to eq 'custom_value'
    end

    it 'applies var interpolation to context headers' do
      expect(req.headers['X-req-context-var']).to eq 'custom_value'
    end

    it 'applies var interpolation to request headers' do
      expect(req.headers['X-req-request-var']).to eq 'custom_value'
    end

    it 'applies var interpolation with environment variables' do
      expect(req.headers['X-custom-1']).to eq 'production'
    end

    it 'applies var interpolation with context variables' do
      expect(req.headers['X-custom-2']).to eq 'context1'
    end

    it 'applies var interpolation with custom variables' do
      expect(req.headers['X-custom-3']).to eq 'custom_value'
    end

    it 'symbolizes and downcases the request method' do
      expect(req.method).to eq :get
    end

    it 'builds uri from environment.endpoint and request path' do
      expect(req.uri).to eq 'https://example.com/example/path'
    end

    it 'interpolate variables present in the uri' do
      # TODO: this test needs too much setup
      env = Environment.new name: 'uritest', endpoint: 'https://${server}'
      config.environments << env
      state.custom_variables.store 'server', 'variableserver'
      state.environment = env

      req = RequestFactory.create(config, state, config.requests.first)
      expect(req.uri).to eq 'https://variableserver/example/path'
    end
  end

  context 'POST request' do
    config = SpecFactory.config
    state = SpecFactory.state
    state.custom_variables.store 'var1', 'value'
    request = Request.new name: 'test', path: '/path', method: 'post', data: '{"key":"${var1}"}'

    req = RequestFactory.create(config, state, request)

    it 'has a valid data attribute' do
      expect(req.data).to be_kind_of String
    end

    it 'interpolates values in data' do
      expect(req.data).to eq '{"key":"value"}'
    end
  end
end
