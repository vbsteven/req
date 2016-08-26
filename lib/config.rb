class Config
  attr_reader :contexts, :environments, :requests

  def initialize(args)
    @contexts = args[:contexts]
    @environments = args[:environments]
    @requests = args[:requests]
  end

  def get_context(ctx_name)
    find_by_name @contexts, ctx_name
  end

  def get_environment(env_name)
    find_by_name @environments, env_name
  end

  def get_request(req_name)
    find_by_name @requests, req_name
  end

  alias :context? :get_context
  alias :environment? :get_environment
  alias :request? :get_request

  private
  def find_by_name(collection, name)
    collection.find { |x| x.name == name }
  end
end
