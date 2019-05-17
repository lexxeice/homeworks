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
    it'returns name' do
      expect(subject.name).to eq :name
    end
  end

  describe '#notifications' do
    it'returns a list of notifications' do
      expect(subject.notifications).to be_an_instance_of(Hash)
    end
  end

  describe '#subscriptions' do
    it'returns list of subscriptions' do
      expect(subject.subscriptions).to be_an_instance_of(Array)
    end
  end

  describe '#subscribe_to' do
    it 'adds student to subscriptions' do
      subject.connect_to(api)
      student.connect_to(api)

      expect(subject.subscribe_to(student, api)).to include(student)
    end
  end

  describe '#subscribed_to?' do
    it 'true' do
      subject.connect_to(api)
      student.connect_to(api)
      subject.subscribe_to(student, api)

      expect(subject.subscribed_to?(student)).to eq true
    end

    it 'false' do
      expect(subject.subscribed_to?(student)).to eq false
    end
  end

  describe '#read_notifications!' do
    it 'changes the status of the notification to read' do
      subject.notifications["#{student.name} has sent #{homework.pr_title}"] = 'UNREAD'
      expect(subject.read_notifications!).to have_value('READ')
    end
  end

  describe '#check' do
    it 'checks homework' do
      expect(subject.check(homework, api)).to eq nil
    end
  end
end
