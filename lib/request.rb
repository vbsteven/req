class Request
  attr_accessor :name, :path, :method, :headers, :variables
  
  def initialize(hash)
    @name = hash[:name] || hash['name'] || ''
    @path = hash[:path] || hash['path'] || ''
    @method = hash[:method] || hash['method'] || ''

    @headers = hash[:headers] || hash['headers'] || {}
    @variables = hash[:variables] || hash['variables'] || {}

  end

end
