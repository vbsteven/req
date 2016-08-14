require 'thor'
require 'yaml'

require 'context'
require 'environment'
require 'request'
require 'state'
require 'config'
require 'prepared_request'
require 'request_factory'
require 'variable_interpolator'
require 'curl_backend'

STATEFILE = '.reqstate'
REQFILE = 'Reqfile'


class Req < Thor

  attr_accessor :config, :state
  @config = nil
  @state = nil

  def self.create_with_config(config)
    req = Req.new
    req.config = config
    req.state = State.new
    req
  end

  desc "contexts", "list all contexts"
  def contexts
    init # TODO avoid this
    @config.contexts.each {|ctx| puts ctx.name }
  end

  desc "context NAME", "switch to context NAME"
  def context(name)
    init
    if @config.contexts.any? { |ctx| ctx.name == name }
      puts "switching to context #{name}"
      @state.context = name
      save_state
    else
      puts "context not found"
      exit 1
    end
  end

  desc "environments", "list all environments"
  def environments
    init
    @config.environments.each {|env| puts env.name }
  end

  desc "environment", "switch to environment"
  def environment(name)
    init
    if @config.has_environment? name
      puts "switching to environment #{name}"
      @state.environment = name
      save_state
    else
      puts "environment not found"
      exit 1
    end
  end

  desc "variable NAME VALUE", "add variable with key NAME and value VALUE"
  def variable(name, value)
    init
    @state.variables[name] = value
    save_state
  end

  desc "variables", "list all custom variables"
  def variables
    init
    @state.variables.each {|key, val| put "#{key}: #{val}" }
  end

  desc "status", "print current environment and context info"
  def status
    init
    puts "context: #{@state.context}"
    puts "environment: #{@state.environment}"
    puts "variables: " # TODO print custom variables
    @state.variables.each { |key,val| puts "    #{key}: #{val}" }
  end

  desc "clear", "clear current context, environment and vars"
  def clear
    @state = State.new
    save_state
  end

  desc "exec REQUESTNAME", "execute request with name REQUESTNAME"
  option :verbose, aliases: '-v'
  option :head, aliases: '-I'
  def exec(requestname)
    init
    request = @config.get_request(requestname)
    prepared_request = RequestFactory.create(@config, @state, request)
    backend = CurlBackend.new prepared_request, options
    backend.execute
  end

  desc "requests", "list all requests"
  def requests
    init
    # TODO provide nice formatting with each column aligned
    @config.requests.each {|req| puts "#{req.name} - #{req.method} #{req.path}"}
  end

  no_commands do
    def init
      return if @config
      @state = State.new
      @config = Config.create_from_yaml(File.read(REQFILE))
      if File.exist? '.reqstate'
        @state = YAML.load(File.read(STATEFILE))
      end
    end

    def save_state
      File.write(STATEFILE, @state.to_yaml)
    end
  end
end
