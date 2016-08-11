class State
  attr_accessor :context, :environment, :variables

  def initialize
    @variables = {}
  end

end
