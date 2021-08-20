require './db/mysql_connector'
require '././models/user'

describe 'user valid?' do
  context 'given valid parameter' do
    it 'should return true' do
      user = User.new({ name: 'a', bio: 'b', created_at: '' })
      expect(user.valid?).to eq(true)
    end
  end
  context 'given invalid parameter' do
    it 'should return false when bio nil' do
      user = User.new({ name: 'a' })
      expect(user.valid?).to eq(false)
    end
  end
  context 'given invalid parameter' do
    it 'should return false when name nil' do
      user = User.new({ bio: 'b' })
      expect(user.valid?).to eq(false)
    end
  end
end

describe 'user save' do
  context 'when executed' do
    it 'should save data' do
      stub_client = double
      stub_query = "INSERT INTO users (name, bio) VALUES ('a', 'b')"
      user = User.new({
                        name: 'a',
                        bio: 'b'
                      })
      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query)
      user.save
    end
  end
end