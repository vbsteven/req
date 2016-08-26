module ConfigFactory
  def self.build_from_yaml(yaml_str)
    yaml = YAML.load yaml_str

    contexts = yaml.fetch('contexts', {}).map { |ctx| Context.new ctx }
    environments = yaml.fetch('environments', {}).map { |env| Environment.new env }
    requests = yaml.fetch('requests', {}).map { |req| Request.new req }

    Config.new(contexts: contexts,
               environments: environments,
               requests: requests)
  end
end
