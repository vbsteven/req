class RequestExecutor

  def initialize(request_name, config, state)
    @request_name = request_name
    @config = config
    @state = state

    @environment = config.get_environment state.environment
    @context = config.get_context state.context
  end

  def merged_variables
    environment_variables = @environment ? @environment.variables : {}
    context_variables = @context ? @context.variables : {}
    variables = @state.variables || {}

    environment_variables.merge(context_variables).merge(variables)
  end

end
