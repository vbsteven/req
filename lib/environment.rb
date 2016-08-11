class Environment
  attr_accessor :name, :variables, :endpoint

  def initialize(hash)
    @name = hash[:name] || hash['name'] || ''
    @endpoint = hash[:endpoint] || hash['endpoint'] || ''
    @variables = hash[:vars] || hash['vars'] || {}

    # TODO raise exceptions when @name or @endpoint is nil or empty
  end
end
