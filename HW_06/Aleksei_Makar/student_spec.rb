require_relative 'student'
require_relative 'homework'

RSpec.describe Student do
  subject { Student.new(name: :name, surname: :surname) }

  describe '#name' do
    it { expect(subject.name).to eq :name }
  end

  describe '#surname' do
    it { expect(subject.surname).to eq :surname }
  end

  describe '#create_homework' do
    it { expect(subject.create_homework(source: 'source', title: 'title').class).to eq Homework }
  end
end
