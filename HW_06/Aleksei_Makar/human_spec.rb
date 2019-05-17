require_relative 'human'

RSpec.describe Human do
  subject { Human.new(name: :name) }
  describe '#name' do
    it 'returns name' do
      expect(subject.name).to eq :name
    end
  end
end
