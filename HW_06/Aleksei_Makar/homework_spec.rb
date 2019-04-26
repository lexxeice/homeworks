require 'json'
require_relative 'homework'
require_relative 'student'


RSpec.describe Homework do
  subject { Homework.new(params) }
  let(:student) { Student.new(name: :name) }
  let(:fake_student) { Student.new(name: :fake_name) }
  let(:params) do
    {
      homework_source: 'source',
      student: student,
      pr_title: 'title'
    }
  end

  describe '#source' do
    context 'returns homework source code' do
      it { expect(subject.source).to eq 'source' }
    end
  end

  describe '#student' do
    context 'returns the student who did this homework' do
      it { expect(subject.student).to be_an_instance_of(Student) }
    end
  end

  describe '#pr_title' do
    context 'returns homework title' do
      it { expect(subject.pr_title).to eq 'title' }
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

    context 'converts homework to json' do
      it { expect(subject.json).to eq expected_body }
    end
  end

  describe '#owner?' do
    context 'when the user is owner' do
      it { expect(subject.owner?(student)).to eq true }
    end
    context 'when the user is not the owner' do
      it { expect(subject.owner?(fake_student)).to eq nil }
    end
  end
end
