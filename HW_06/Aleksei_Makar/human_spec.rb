require_relative 'human'

RSpec.describe Human do
  subject { Human.new(name: :name) }
  describe '#name' do
    context 'returns name' do
      it { expect(subject.name).to eq :name }
    end
  end
end
