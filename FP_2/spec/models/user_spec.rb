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

describe 'user update' do
  context 'when executed' do
    it 'should change data' do
      stub_client = double
      stub_query = "UPDATE users SET bio='b' WHERE name = 'a'"
      user = User.new({
                        name: 'a',
                        bio: 'b'
                      })
      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query)
      user.update
    end
  end
end

describe 'user get all' do
  context 'when executed' do
    it 'should return all data' do
      stub_client = double
      stub_query = 'SELECT u.name as name, u.bio as bio, u.created_at as created_at FROM users u'
      users = [{ "name": 'a', "bio": 'b', "created_at": 'c' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(users)

      get_user = User.all
      expect(get_user).not_to be_nil
    end
  end
end

describe 'user is user by name' do
  context 'when user exist' do
    it 'should return true' do
      stub_client = double
      stub_query = "select name from users where name = 'a'"
      users = [{ "name": 'a' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(users)

      found_user = User.user_by_name?('a')
      expect(found_user).to eq(true)
    end
  end

  context 'user when user not exist' do
    it 'should return false' do
      stub_client = double
      stub_query = "select name from users where name = 'a'"
      users = []

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(users)

      found_user = User.user_by_name?('a')
      expect(found_user).to eq(false)
    end
  end
end

describe 'user find by name' do
  context 'when data found' do
    it 'should return exactly 1 data' do
      stub_client = double
      stub_query = "select * from users where name = 'a'"
      users = [{ "id": 1, "name": 'a', "bio": 'b', "created_at": 'c' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(users)

      found_user = User.find_by_name('a')
      expect(found_user).not_to be_nil
    end
  end

  context 'user when data not found' do
    it 'should return empty' do
      stub_client = double
      stub_query = "select * from users where name = 'a'"

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return([])

      found_user = User.find_by_name('a')
      expect(found_user).to eq(nil)
    end
  end
end

describe 'user delete' do
  context 'when executed' do
    it 'should delete data' do
      stub_client = double
      stub_query = "DELETE FROM users WHERE name = 'a'"
      user = User.new({
                        name: 'a',
                        bio: 'b'
                      })
      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query)
      user.delete
    end
  end
end