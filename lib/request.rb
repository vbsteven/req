class Request
  attr_reader :name, :path, :method, :headers, :variables, :data

  def initialize(args)
    @name = args[:name]
    @path = args[:path]
    @method = args[:method]

    @headers = args[:headers] || {}
    @variables = args[:vars] || {}
    @data = args[:data]
  end
end
