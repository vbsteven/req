class Environment
  attr_accessor :name, :variables, :endpoint

  def initialize(hash)
    @name = hash[:name] || hash['name'] || ''
    @endpoint = hash[:endpoint] || hash['endpoint'] || ''
    @variables = hash[:variables] || hash['variables']

    # TODO raise exceptions when @name or @endpoint is nil or empty
  end
end
