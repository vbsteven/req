
describe 'Req' do
  let(:req) { Req.new }

  it 'is a Thor app' do
    expect(req).to be_kind_of Thor
  end

  available_commands = [:context, :contexts, :environment, :environments]
  available_commands.each do |cmd|
    it "responds to #{cmd} command" do
      expect(req).to respond_to cmd
    end
  end
end
