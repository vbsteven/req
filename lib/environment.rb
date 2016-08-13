class Environment
  attr_accessor :name, :variables, :endpoint, :headers

  def initialize(hash)
    @name = hash[:name] || hash['name'] || ''
    @endpoint = hash[:endpoint] || hash['endpoint'] || ''
    @variables = hash[:vars] || hash['vars'] || {}
    @headers = hash[:headers] || hash['headers'] || {}

    # TODO raise exceptions when @name or @endpoint is nil or empty
  end
end
