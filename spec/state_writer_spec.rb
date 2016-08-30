
describe StateWriter do

  context '#stringify' do

    let(:state) { SpecFactory.state }

    it 'returns valid yaml' do
      expect { YAML.parse(subject.stringify(state)) }.not_to raise_error
    end

    it 'saves context name' do
      expect(subject.stringify(state)).to match /^context: context1/
    end

    it 'saves environment name' do
      expect(subject.stringify(state)).to match /^environment: production/
    end

    it 'saves custom variables' do
      expect(subject.stringify(state)).to match /^custom_variables:/
      expect(subject.stringify(state)).to match /^  custom_var1: custom value 1/
    end
  end

  context '#write' do

    let(:state) { SpecFactory.state }

    it 'calls #write on given file' do
      file = double('File')

      expect(file).to receive(:write).with(subject.stringify(state))
      subject.write(state, file)
    end

  end
end
