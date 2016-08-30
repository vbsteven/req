class RequestFactory
  def self.create(config, state, request)
    environment = state.environment
    context = state.context

    variables = merge_variables(environment, context, request, state.custom_variables)
    interpolator = VariableInterpolator.new(variables)

    PreparedRequest.new(
      headers: build_headers(environment, context, request, interpolator),
      method: request.method.downcase.to_sym,
      uri: build_uri(environment, request, interpolator),
      data: build_data(request, interpolator)
    )
  end

  def self.merge_variables(environment, context, request, custom_variables)
    (environment.variables || {})
      .merge(context.variables || {})
      .merge(request.variables || {})
      .merge(custom_variables || {})
  end

  def self.build_headers(environment, context, request, interpolator)
    environment.headers
               .merge(context.headers)
               .merge(request.headers)
               .map { |key, value| [key, interpolator.interpolate(value)] }.to_h
  end

  def self.build_uri(environment, request, interpolator)
    uri = environment.endpoint + request.path
    interpolator.interpolate(uri)
  end

  def self.build_data(request, interpolator)
    return nil if request.data.nil?

    interpolator.interpolate(request.data)
  end
end
