require_relative 'mentor'
require_relative 'student'
require_relative 'homework'
require_relative 'api'

RSpec.describe Mentor do
  subject { Mentor.new(name: :name) }
  let(:api) { Api.new }
  let(:student) { Student.new(name: 'Alex') }
  let(:homework) { Homework.new(params) }
  let(:params) do
    {
      homework_source: 'source',
      student: student,
      pr_title: 'title'
    }
  end

  describe '#name' do
    context 'returns name' do
      it { expect(subject.name).to eq :name }
    end
  end

  describe '#notifications' do
    context 'returns a list of notifications' do
      it { expect(subject.notifications).to be_an_instance_of(Hash) }
    end
  end

  describe '#subscriptions' do
    context 'returns list of subscriptions' do
      it { expect(subject.subscriptions).to be_an_instance_of(Array) }
    end
  end

  before(:each) do
    subject.connect_to(api)
    student.connect_to(api)
    subject.subscribe_to(student, api)
  end

  describe '#subscribe_to' do
    context 'adds student to subscriptions' do
      it 'subscriptions must include student' do
        expect(subject.subscribe_to(student, api)).to include(student)
      end
    end
  end

  describe '#subscribed_to?' do
    context 'check subscription status' do
      it { expect(subject.subscribed_to?(student)).to eq true }
    end
  end

  describe '#read_notifications!' do
    context 'changes the status of the notification to read' do
      it do
        subject.notifications["#{student.name} has sent #{homework.pr_title}"] = 'UNREAD'
        expect(subject.read_notifications!).to have_value('READ')
      end
    end
  end

  describe '#check' do
    context 'checks homework' do
      it { expect(subject.check(homework, api)).to eq nil }
    end
  end
end
