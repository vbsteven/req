class State
  attr_accessor :context, :environment, :custom_variables

  def initialize(args = {})
    @context = args[:context] || Context.new
    @environment = args[:environment] || Environment.new
    @custom_variables = args[:custom_variables] || {}
  end

  def variables
    environment.variables
      .merge(context.variables)
      .merge(custom_variables)
  end
end
