require '././db/mysql_connector'
require '././controllers/post_controller'
require '././models/post'

describe '#create' do
  context 'given valid parameter' do
    it 'make a new post' do
      stub = double

      controller = PostController.new
      params = {
        "id": 1,
        "content": 'a',
        "attachment": '',
        "user_name": 'b'
      }
      post = Post.new(params)

      expect(Post).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(true)
      expect(User).to receive(:user_by_name?).and_return(true)
      expect(stub).to receive(:save).and_return(true)
      expect(Post).to receive(:find_by_id).with(1).and_return(post)
      expect(stub).to receive(:comment?).and_return(false)

      result_string = controller.create(params)
      expect(result_string).to eq('post created')

      result = Post.find_by_id(1)
      expect(result).not_to be_nil
    end
  end
end