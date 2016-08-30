class VariableInterpolator
  attr_reader :variables

  def initialize(variables = {})
    @variables = variables.map { |key, value| [key.to_sym, value] }.to_h
  end

  def interpolate(input)
    input.gsub(/\${[a-zA-Z0-9\-_]*}/) do |m|
      var = m.scan(/[a-zA-Z0-9\-_]+/).first.to_sym
      variables[var]
    end
  end
end
