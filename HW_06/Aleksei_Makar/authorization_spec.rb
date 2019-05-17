require_relative 'authorization'
require_relative 'api'

# Fake User
class User
  include Authorization
end

RSpec.describe Authorization do
  subject { User.new }
  let(:api) { Api.new }

  describe '#connect_to' do
    it 'adds a user to the list of users in GitHub' do
      expect(subject.connect_to(api)).to eq User
    end
  end
end
