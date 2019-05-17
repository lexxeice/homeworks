require_relative 'api'
require_relative 'student'
require_relative 'mentor'
require_relative 'homework'

RSpec.describe Api do
  subject { Api.new }
  let(:mentor) { Mentor.new(name: 'Maks') }
  let(:student) { Student.new(name: 'Alex') }
  let(:fake_student) { Student.new(name: 'fake_Alex') }
  let(:homework) { Homework.new(params) }
  let(:params) do
    {
      homework_source: 'source',
      student: student,
      pr_title: 'title'
    }
  end

  describe '#users_list' do
    it 'returns a list of users' do
      expect(subject.users_list).to be_an_instance_of(Hash)
    end
  end

  describe '#homework_list' do
    it 'returns homework list' do
      expect(subject.homework_list).to be_an_instance_of(Hash)
    end
  end

  describe '#add_user' do
    it 'adds user to users list' do
      subject.add_user(student)
      subject.add_user(mentor)

      expect(subject.users_list).to include(student).and include(mentor)
    end
  end

  describe '#add_homework' do
    it 'adds homework to homework list' do
      subject.add_homework(student, homework)

      expect(subject.homework_list).to include(homework)
    end
  end

  describe '#send_notification' do
    it 'sends notification to mentor' do
      subject.add_user(student)
      subject.add_user(mentor)
      subject.add_homework(student, homework)
      mentor.subscribe_to(student, subject)

      subject.send_notification(student, homework.pr_title)
      expect(mentor.notifications)
        .to have_key("#{student.name} has sent #{homework.pr_title}")
        .and have_value('UNREAD')
    end
  end

  describe '#user_connected?' do
    it 'true' do
      subject.add_user(student)

      expect(subject.user_connected?(student)).to eq true
    end
    it 'false' do
      expect(subject.user_connected?(student)).to eq nil
    end
  end

  describe '#subscription_possible?' do
    it 'true' do
      subject.add_user(student)
      subject.add_user(mentor)

      expect(subject.subscription_possible?(mentor, student)).to eq true
    end
    it 'false' do
      expect(subject.subscription_possible?(mentor, student)).to eq nil
    end
  end

  describe '#include?' do
    it 'true' do
      subject.add_homework(student, homework)
      expect(subject.include?(homework)).to eq true
    end
    it 'false' do
      expect(subject.include?(homework)).to eq nil
    end
  end

  describe '#entered_result' do
    it 'Succeeded' do
      allow(subject).to receive(:gets) { "Y\n" }
      expect(subject.entered_result(homework)).to eq 'Succeeded'
    end
    it 'Failed' do
      allow(subject).to receive(:gets) { "N\n" }
      expect(subject.entered_result(homework)).to eq 'Failed'
    end
  end
end
