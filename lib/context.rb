class Context
  attr_accessor :name, :variables, :headers

  def initialize(hash)
    @name = hash[:name] || hash['name'] || 'default_context'
    @variables = hash[:vars] || hash['vars'] || {}
    @headers = hash[:headers] || hash['headers'] || {}
  end

end
