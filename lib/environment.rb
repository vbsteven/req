class Environment
  attr_reader :name, :variables, :endpoint, :headers

  def initialize(hash = {})
    @name = hash[:name]
    @endpoint = hash[:endpoint]
    @variables = hash[:variables] || {}
    @headers = hash[:headers] || {}
  end
end
