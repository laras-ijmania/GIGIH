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