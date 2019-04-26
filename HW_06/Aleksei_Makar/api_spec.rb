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
    context 'returns a list of users' do
      it { expect(subject.users_list).to be_an_instance_of(Hash) }
    end
  end

  describe '#homework_list' do
    context 'returns homework list' do
      it { expect(subject.homework_list).to be_an_instance_of(Hash) }
    end
  end

  before(:each) do
    subject.add_user(student)
    subject.add_user(mentor)
    subject.add_homework(student, homework)
    mentor.subscribe_to(student, subject)
  end

  describe '#add_user' do
    context 'adds user to users list' do
      it 'must include all users instances' do
        expect(subject.users_list).to include(student).and include(mentor)
      end
    end
  end

  describe '#add_homework' do
    context 'adds homework to homework list' do
      it 'must include all homeworks instances' do
        expect(subject.homework_list).to include(homework)
      end
    end
  end

  describe '#send_notification' do
    context 'sends notification to mentor' do
      it do
        subject.send_notification(student, homework.pr_title)
        expect(mentor.notifications)
        .to have_key("#{student.name} has sent #{homework.pr_title}")
        .and have_value('UNREAD')
      end
    end
  end

  describe '#user_connected?' do
    context 'checks the connection status' do
      it 'connected' do
        expect(subject.user_connected?(student)).to eq true
      end
      it 'not connected' do
        expect(subject.user_connected?(fake_student)).to eq nil
      end
    end
  end

  describe '#subscription_possible?' do
    context 'checks the possibility of subscription' do
      it 'true' do
        expect(subject.subscription_possible?(mentor,student)).to eq true
      end
      it 'false' do
        expect(subject.subscription_possible?(mentor, fake_student)).to eq nil
      end
    end
  end

  describe '#include?' do
    let(:fake_homework) { Homework.new(params2) }
    let(:params2) do
      {
        homework_source: 'source2',
        student: student,
        pr_title: 'title2'
      }
    end
    context 'checks for homework in the homework list' do
      it 'true' do
        expect(subject.include?(homework)).to eq true
      end
      it 'false' do
        expect(subject.include?(fake_homework)).to eq nil
      end
    end
  end

  describe '#entered_result' do
    context 'changes the status of homework' do
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
end
