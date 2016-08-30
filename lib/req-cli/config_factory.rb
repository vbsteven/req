# Factory responsible for building valid Config objects from YAML input
module ConfigFactory
  def self.build_from_yaml(yaml_str)
    yaml = YAML.load yaml_str

    contexts = yaml.fetch('contexts', {}).map { |ctx| build_context ctx }
    environments = yaml.fetch('environments', {}).map { |env| build_environment env }
    requests = yaml.fetch('requests', {}).map { |req| build_request req }

    Config.new(contexts: contexts,
               environments: environments,
               requests: requests)
  end

  def self.build_context(args)
    Context.new(name: args.fetch('name'),
                variables: args.fetch('vars', {}),
                headers: args.fetch('headers', {}))
  end

  def self.build_environment(args)
    Environment.new(name: args.fetch('name'),
                    endpoint: args.fetch('endpoint'),
                    variables: args.fetch('vars', {}),
                    headers: args.fetch('headers', {}))
  end

  def self.build_request(args)
    Request.new(name: args.fetch('name'),
                path: args.fetch('path'),
                method: args.fetch('method', 'get'),
                headers: args.fetch('headers', {}),
                variables: args.fetch('vars', {}),
                data: args.fetch('data', nil))
  end
end
