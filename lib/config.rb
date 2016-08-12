
class Config
  attr_accessor :contexts, :environments, :requests

  def initialize(hash)
    @contexts = hash[:contexts] || hash['contexts'] || {}
    @contexts = @contexts.map {|ctx| Context.new(ctx) }

    @environments = hash[:environments] || hash['environments'] || {}
    @environments = @environments.map { |env| Environment.new(env) }

    @requests = hash[:requests] || hash['requests'] || {}
    @requests = @requests.map { |req| Request.new(req) }
  end

  def self.create_from_yaml(yaml_string)
    return Config.new YAML.load(yaml_string)
  end

  def has_context?(ctx_name)
    @contexts.any? {|ctx| ctx.name == ctx_name }
  end

  def get_context(ctx_name)
    @contexts.find {|ctx| ctx.name == ctx_name }
  end

  def has_environment?(env_name)
    @environments.any? {|env| env.name == env_name }
  end

  def get_environment(env_name)
    @environments.find {|env| env.name == env_name }
  end

  def has_request?(env_name)
    @requests.any? {|env| env.name == env_name }
  end

  def get_request(env_name)
    @requests.find {|env| env.name == env_name }
  end

end
