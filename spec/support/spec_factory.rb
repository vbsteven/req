module SpecFactory

  REQFILE_LOCATION = 'spec/Reqfile.example'
  REQSTATE_LOCATION = 'spec/Reqstate.example'

  def self.config_yaml_str
    File.read(REQFILE_LOCATION)
  end

  def self.config
    ConfigFactory.build_from_yaml(config_yaml_str)
  end

  def self.state_yaml_str
    File.read(REQSTATE_LOCATION)
  end

  def self.state
    StateFactory.build_from_yaml(state_yaml_str, config)
  end
end
