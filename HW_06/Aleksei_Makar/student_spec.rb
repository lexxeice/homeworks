require_relative 'student'
require_relative 'homework'
require_relative 'authorization'
require_relative 'homework'
require_relative 'api'

RSpec.describe Student do
  subject { Student.new(name: :name) }
  let(:api) { Api.new }
  let(:homework) { Homework.new(params) }
  let(:params) do
    {
      homework_source: 'source',
      student: subject,
      pr_title: 'title'
    }
  end

  describe '#name' do
    context 'returns name' do
      it { expect(subject.name).to eq :name }
    end
  end

  describe '#create_homework' do
    context 'creates an instance of homework' do
      it { expect(subject.create_homework(source: 'source', title: 'title')).to be_an_instance_of(Homework) }
    end
  end

  describe '#submit_homework' do
    let(:expected_body) do
      {
        source: 'source',
        student: subject.name,
        pr_title: 'title'
      }.to_json
    end

    before do
      subject.connect_to(api)
      stub_request(:post, "http://www.example.com/").
        with(
          headers: {
            'Content-Type'=>'application/json',
          }).
        to_return(status: 200, body: "", headers: {})
    end

    context 'performs POST request to GitHub' do
      it do
        subject.submit_homework(homework, api)
        expect(WebMock).to have_requested(:post, "www.example.com").with { |req| req.body == expected_body }
      end
    end
  end
end
