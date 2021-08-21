require '././db/mysql_connector'
require '././controllers/user_controller'
require '././models/user'

describe '#create' do
  context 'given valid parameter' do
    it 'make a new user' do
      stub = double
      controller = UserController.new
      params = { 'name' => 'a', 'bio' => 'b' }
      user = User.new(params)
      expect(User).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(true)
      expect(stub).to receive(:save)
      expect(User).to receive(:find_by_name).with('a').and_return(user)
      controller.create(params)
      result = User.find_by_name('a')
      expect(result).not_to be_nil
    end
  end
end
describe '#create' do
  context 'given invalid parameter' do
    it 'should return false' do
      stub = double
      controller = UserController.new
      params = { 'name' => 'a' }
      expect(User).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(false)
      result = controller.create(params)
      expect(result).to eq(false)
    end
  end
end
describe '#create' do
  context 'given invalid parameter' do
    it 'should return false' do
      stub = double
      controller = UserController.new
      params = { 'bio' => 'a' }
      expect(User).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(false)
      result = controller.create(params)
      expect(result).to eq(false)
    end
  end
end

describe '#index' do
  context 'given valid parameter' do
    it 'should show all user' do
      controller = UserController.new
      params = { "name": 'a', "bio": 'b' }
      user = User.new(params)
      users = [user]
      expect(User).to receive(:all).and_return(users)
      result = controller.index
      expected = '[{"name":"a","bio":"b","created_at":null}]'
      expect(result).to eq(expected)
    end
  end
end

describe '#show' do
  context 'if user found' do
    it 'should show 1 post if found and all the comments' do
      params = { "name": 'a', "bio": 'b' }
      controller = UserController.new
      expect(User).to receive(:find_by_name).and_return(params)
      result = controller.show(params)
      expected = '{"name":"a","bio":"b"}'
      expect(result).to eq(expected)
    end
  end

  context 'given valid parameter' do
    it 'should show 1 user if found' do
      params = { 'name' => 'a' }
      controller = UserController.new
      expect(User).to receive(:find_by_name).and_return(nil)
      result = controller.show(params)
      expected = nil
      expect(result).to eq(expected)
    end
  end
end