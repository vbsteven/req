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
require 'config_factory'
require 'state_factory'
require 'state_writer'

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

  desc 'contexts', 'list all contexts'
  def contexts
    init # TODO: avoid this
    @config.contexts.each { |ctx| puts ctx.name }
  end

  desc 'context NAME', 'switch to context NAME'
  def context(name)
    init
    exit_with_message 'unknown context' unless @config.context? name
    puts "switching to context #{name}"
    @state.context = @config.get_context name
    save_state
  end

  desc 'environments', 'list all environments'
  def environments
    init
    @config.environments.each { |env| puts env.name }
  end

  desc 'environment', 'switch to environment'
  def environment(name)
    init
    exit_with_message 'environment not found' unless @config.environment? name
    puts "switching to environment #{name}"
    @state.environment = @config.get_environment name
    save_state
  end

  desc 'variable NAME VALUE', 'add variable with key NAME and value VALUE'
  def variable(name, value)
    init
    @state.custom_variables[name] = value
    save_state
  end

  desc 'variables', 'list all custom variables'
  def variables
    init
    @state.custom_variables.each { |key, val| put "#{key}: #{val}" }
  end

  desc 'status', 'print current environment and context info'
  def status
    init
    puts "context: #{@state.context.name if @state.context}"
    puts "environment: #{@state.environment.name if @state.environment}"
    puts 'variables: '
    @state.custom_variables.each { |key, val| puts "    #{key}: #{val}" }
  end

  desc 'clear', 'clear current context, environment and vars'
  def clear
    @state = State.new
    save_state
  end

  desc 'exec REQUESTNAME', 'execute request with name REQUESTNAME'
  option :verbose, aliases: '-v'
  option :head, aliases: '-I'
  def exec(requestname)
    init
    valid_for_execution?
    request = @config.get_request(requestname)
    prepared_request = RequestFactory.create(@config, @state, request)
    backend = CurlBackend.new prepared_request, options
    backend.execute
  end

  desc 'requests', 'list all requests'
  def requests
    init
    @config.requests.each { |req| puts "#{req.name} \t#{req.method} \t#{req.path}" }
  end

  no_commands do
    def init
      return if @config
      @config = ConfigFactory.build_from_yaml(File.read(REQFILE))
      @state = StateFactory.build_from_yaml(File.read(STATEFILE), @config) if File.exist? STATEFILE
      @state = State.new unless File.exist? STATEFILE
    end

    def valid_for_execution?
      exit_with_message 'No valid environment specified, use req environment NAME to choose an environment' if @state.environment.nil?
      exit_with_message 'No valid context specified, use req context NAME to choose a context' if @state.context.nil?
      true
    end

    def save_state
      File.open(STATEFILE, 'w') do |file|
        StateWriter.write(@state, file)
      end
    end

    def exit_with_message(message)
      puts message
      exit 1
    end
  end
end
