class Context
  attr_accessor :name, :variables

  def initialize(hash)
    @name = hash[:name] || hash['name'] || 'default_context'
    @variables = hash[:vars] || hash['vars'] || {}
  end

end
