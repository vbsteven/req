class VariableInterpolator

  attr_accessor :variables

  def initialize(variables = {})
    @variables = variables.map { |key, value| [key.to_sym, value] }.to_h
  end

  def interpolate(input)
    input.gsub(/\${[a-zA-Z0-9]*}/) do |m|
      var = m.scan(/[a-zA-Z0-9]+/).first.to_sym
      variables[var]
    end
  end

end
