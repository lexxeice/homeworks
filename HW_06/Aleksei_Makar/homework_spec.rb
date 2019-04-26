require 'json'
require_relative 'homework'
require_relative 'student'


RSpec.describe Homework do
  subject { Homework.new(homework_source: 'source', student: student, pr_title: 'title') }
  let(:student) { Student.new(name: :name) }
  let(:fake_student) { Student.new(name: :fake_name) }

  describe '#source' do
    it 'returns homework source code' do
      expect(subject.source).to eq 'source'
    end
  end

  describe '#student' do
    it 'returns the student who did this homework' do
      expect(subject.student).to eq student
    end
  end

  describe '#pr_title' do
    it 'returns homework title' do
      expect(subject.pr_title).to eq 'title'
    end
  end

  describe '#json' do
    let(:expected_body) do
      {
        source: 'source',
        student: student.name,
        pr_title: 'title'
      }.to_json
    end

    it 'converts homework to json' do
      expect(subject.json).to eq expected_body
    end
  end

  describe '#owner?' do
    it 'when the user is owner' do
      expect(subject.owner?(student)).to eq true
    end
    it 'when the user is not the owner' do
      expect(subject.owner?(fake_student)).to eq nil
    end
  end
end
