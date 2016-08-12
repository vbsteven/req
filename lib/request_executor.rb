require 'httparty'

class RequestExecutor

  def initialize(request_name, config, state, options)
    @request_name = request_name
    @config = config
    @state = state
    @options = options

    @environment = config.get_environment state.environment
    @context = config.get_context state.context
    @request = config.get_request(request_name)
  end

  def merged_variables
    environment_variables = @environment ? @environment.variables : {}
    context_variables = @context ? @context.variables : {}
    variables = @state.variables || {}

    environment_variables.merge(context_variables).merge(variables)
  end

  def uri
    @environment.endpoint + @request.path
  end

  def execute
    puts "request: #{@request}"
    method = @request.method.upcase
    body = {} # TODO fill in body
    headers = @request.headers || {}

    # TODO apply variables to body, headers, endpoint, path and any other relevant spot

    puts "executing request with following params:"
    puts "  method: #{@request.method.upcase}"
    puts "  uri: #{uri}"
    puts "  body: #{body}" if body.any?

    #if headers.any?
      #puts "  headers:"
      #headers.each {|name, value| puts "    #{name}: #{value}"}
    #end

    #response = HTTParty.send(method.to_sym, uri, body: body, headers: headers)

    #response_status_code = response.code
    #response_headers = response.headers
    #response_body = response.body
    #
    # TODO check for presence of the curl binary
    header_string = headers.map {|key, val| "-H '#{key}: #{val}'"}.join ' '
    verbose = @options[:verbose] ? '-v' : ''

    curl_command = "curl -X #{method} #{verbose} #{header_string} #{uri}"

    puts "executing: #{curl_command}"
    system curl_command

  end

  private


end
