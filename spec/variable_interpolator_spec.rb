describe 'VariableInterpolator' do
  context 'initializer' do
    let(:interpolator) { VariableInterpolator.new var1: 'value1', var2: 'value2' }

    it 'takes hash of variables as initializer param' do
      expect(interpolator.variables).to be_kind_of Hash
      expect(interpolator.variables.count).to eq 2
      expect(interpolator.variables[:var1]).to eq 'value1'
      expect(interpolator.variables[:var2]).to eq 'value2'
    end
  end

  context 'interpolate' do
    let(:interpolator) { VariableInterpolator.new var1: 'value1', var2: 'value2' }

    it 'does nothing when no values are present' do
      expect(interpolator.interpolate('test')).to eq 'test'
    end

    it 'interpolates single variables' do
      expect(interpolator.interpolate('test ${var1}')).to eq 'test value1'
    end

    it 'interpolates multiple variables' do
      expect(interpolator.interpolate('test ${var1} ${var2}')).to eq 'test value1 value2'
    end
  end
end
