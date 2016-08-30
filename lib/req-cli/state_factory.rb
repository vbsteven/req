module StateFactory
  def self.build_from_yaml(yaml_str, config)
    yaml = YAML.load yaml_str

    raise 'Invalid YAML' unless yaml.kind_of? Hash

    State.new(environment: build_environment(yaml, config),
              context: build_context(yaml, config),
              custom_variables: build_custom_variables(yaml, config))
  end

  def self.build_context(hash, config)
    name = hash['context']
    config.get_context(name) || Context.new
  end

  def self.build_environment(hash, config)
    name = hash['environment']
    config.get_environment(name) || Environment.new
  end

  def self.build_custom_variables(hash, config)
    hash['custom_variables'] || {}
  end
end
