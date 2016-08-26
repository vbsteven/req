class Request
  attr_accessor :name, :path, :method, :headers, :variables, :data

  def initialize(args)
    @name = args[:name] || args['name'] || ''
    @path = args[:path] || args['path'] || ''
    @method = args[:method] || args['method'] || ''

    @headers = args[:headers] || args['headers'] || {}
    @variables = args[:vars] || args['vars'] || {}
    @data = args[:data] || args['data'] || nil
  end
end
