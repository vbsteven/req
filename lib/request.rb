class Request
  attr_accessor :name, :path, :method, :headers
  
  def initialize(hash)
    @name = hash[:name] || hash['name'] || ''
    @path = hash[:path] || hash['path'] || ''
    @method = hash[:method] || hash['method'] || ''

    @headers = hash[:headers] || hash['headers'] || ''

  end

end
