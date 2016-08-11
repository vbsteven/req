#!env ruby

require 'thor'
require 'yaml'

STATEFILE = '.reqstate'
REQFILE = 'Reqfile'

class State
  attr_accessor :context, :environment, :variables

  def initialize
    @variables = {}
  end
end

class Req < Thor
  @config
  @state

  desc "contexts", "list all contexts"
  def contexts
    load_config # TODO avoid this
    @config['contexts'].keys.each {|name| puts name }
  end

  desc "context NAME", "switch to context NAME"
  def context(name)
    load_config
    if @config['contexts'].keys.include? name
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
    load_config # TODO avoid this
    @config['environments'].keys.each {|name| puts name }
  end

  desc "environment", "switch to environment"
  def environment(name)
    load_config
    if @config['environments'].keys.include? name
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
    load_config
    @state.variables[name] = value
    save_state
  end

  desc "status", "print current environment and context info"
  def status
    load_config
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
  def exec(requestname)
    puts "executing request"
  end

  no_commands do
    def load_config
      @state = State.new
      @config = YAML.load(File.read(REQFILE))
      if File.exist? '.reqstate'
        @state = YAML.load(File.read(STATEFILE))
      end
    end

    def save_state
      File.write(STATEFILE, @state.to_yaml)
    end
  end
end

Req.start(ARGV)
