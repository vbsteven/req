describe 'Context' do
  context 'initialize' do

    let (:ctx) { Context.new name: 'ctx', variables: { key: 'value' } }

    it 'extracts name from initializer hash' do
      expect(ctx.name).to eq 'ctx'
    end

    it 'extract variables from initializer hash' do
      expect(ctx.variables).to be_kind_of Hash
      expect(ctx.variables.keys.first).to eq :key
      expect(ctx.variables[:key]).to eq 'value'
    end

  end
end
