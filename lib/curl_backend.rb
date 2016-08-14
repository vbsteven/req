class CurlBackend

  def initialize(prepared_request, options={})
    @request = prepared_request
    @curl_options = parse_curl_options(options)
  end

  def execute
    header_string = @request.headers.map {|key, val| "-H '#{key}: #{val}'"}.join ' '
    data_string = @request.data ? "-d '#{@request.data}'" : ""

    curl_command = "curl -X #{@request.method.upcase} #{header_string} #{data_string} #{@curl_options}  #{@request.uri}"
    puts curl_command
    system curl_command
  end

  def parse_curl_options(options)
    opts = ''

    if options.has_key? 'verbose'
      opts += '--verbose '
    end

    if options.has_key? 'head'
      opts += ' --head '
    end

    opts
  end

end
