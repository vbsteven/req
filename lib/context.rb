class Context
  attr_reader :name, :variables, :headers

  def initialize(hash = {})
    @name = hash[:name] || ''
    @variables = hash[:variables] || {}
    @headers = hash[:headers] || {}
  end
end
