module StateWriter

  def self.stringify(state)
    {
      'context' => state.context.name || '',
      'environment' => state.environment.name,
      'custom_variables' => state.custom_variables
    }.to_yaml
  end

  def self.write(state, file)
    file.write(stringify(state))
  end
end
