class Context
  attr_reader :name, :variables, :headers

  def initialize(hash = {})
    @name = hash[:name] || default_context
    @variables = hash[:variables] || {}
    @headers = hash[:headers] || {}
  end

  def default_context
    'default_context'
  end
end
