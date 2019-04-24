require_relative 'human'

RSpec.describe Human do
  subject { Human.new(name: :name, surname: :surname) }
  describe '#name' do
    it { expect(subject.name).to eq :name }
  end
  describe '#surname' do
    it { expect(subject.surname).to eq :surname }
  end
end
