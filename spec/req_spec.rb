describe 'Req' do
  let(:req) do
    config = SpecFactory.config
    Req.create_with_config(config)
  end

  available_commands =
    [:context, :contexts, :environment, :environments, :requests]
  available_commands.each do |cmd|
    it "responds to #{cmd} command" do
      expect(req).to respond_to cmd
    end
  end

  context 'contexts command' do
    it 'prints all contexts to stdout' do
      expect { req.contexts }.to output("context1\ncontext2\n").to_stdout
    end
  end

  context 'context command' do
    it 'changes current context' do
      expect { req.context('context1') }.to output(/.*context1.*/).to_stdout
      expect(req.state.context.name).to eq 'context1'
    end
  end

  context 'environments command' do
    it 'prints all environments to stdout' do
      expect { req.environments }.to output("production\nstaging\ndevelopment\n").to_stdout
    end
  end

  context 'environment command' do
    it 'changes current environment' do
      req.state.environment = 'development'
      expect { req.environment('production') }.to(
        output(/.*production.*/).to_stdout
      )
      expect(req.state.environment.name).to eq 'production'
    end
  end

  context 'status command' do
    it 'outputs current environment' do
      req.environment 'production'
      expect { req.status }.to output(/.*environment.*production.*/).to_stdout
    end

    it 'outputs current context' do
      req.context 'context1'
      expect { req.status }.to output(/.*context.*context1.*/).to_stdout
    end
  end

  context 'requests command' do
    it 'outputs request info' do
      expect { req.requests }.to(
        output(%r{^exampleRequest[\s]+GET[\s]+/example/path$}).to_stdout
      )
    end
  end
end
