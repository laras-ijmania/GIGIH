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

  context 'given valid parameter' do
    it 'make a new comment' do
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
      expect(stub).to receive(:comment?).and_return(true)
      expect(stub).to receive(:relatedId).and_return(1)
      expect(Post).to receive(:post_by_id?).with(1).and_return(true)
  
      result_string = controller.create(params)
      expect(result_string).to eq('post created')
  
      result = Post.find_by_id(1)
      expect(result).not_to be_nil
    end
  end
  
  context 'given related id not found' do
    it 'return post not found' do
      stub = double
  
      controller = PostController.new
      params = {
        "id": 1,
        "content": 'a',
        "attachment": '',
        "user_name": 'b'
      }
  
      expect(Post).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(true)
      expect(User).to receive(:user_by_name?).and_return(true)
      expect(stub).to receive(:comment?).and_return(true)
      expect(stub).to receive(:relatedId).and_return(1)
      expect(Post).to receive(:post_by_id?).with(1).and_return(false)
  
      result_string = controller.create(params)
      expect(result_string).to eq('post not found')
    end
  end

  context 'given sql error' do
    it 'return post not created' do
      stub = double
  
      controller = PostController.new
      params = {
        "id": 1,
        "content": 'a',
        "attachment": '',
        "user_name": 'b',
        "related_id": ''
      }
      expect(Post).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(true)
      expect(User).to receive(:user_by_name?).and_return(true)
      expect(stub).to receive(:save).and_return(false)
      expect(stub).to receive(:comment?).and_return(false)
  
      result_string = controller.create(params)
      expect(result_string).to eq('post not created')
    end
  end
  
  context 'given invalid post' do
    it 'should return invalid post' do
      stub = double
  
      controller = PostController.new
      params = {
        'user_name' => 'a'
      }
  
      expect(Post).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(false)
  
      result = controller.create(params)
  
      expected = 'invalid post'
  
      expect(result).to eq(expected)
    end
  end
  
  context 'given invalid post' do
    it 'should return invalid post' do
      stub = double
      controller = PostController.new
      params = {
        'content' => 'a'
      }
      expect(Post).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(false)
  
      result = controller.create(params)
  
      expected = 'invalid post'
  
      expect(result).to eq(expected)
    end
  end
  
  context 'given user not found' do
    it 'should return user not found' do
      stub = double
      controller = PostController.new
      params = {
        "id": 1,
        "content": 'a',
        "attachment": '',
        "user_name": 'b',
        "related_id": ''
      }
      expect(Post).to receive(:new).with(params).and_return(stub)
      expect(stub).to receive(:valid?).and_return(true)
      expect(User).to receive(:user_by_name?).and_return(false)
      result = controller.create(params)
      expected = 'user not found'
      expect(result).to eq(expected)
    end
  end
end

describe '#index' do
  context 'given valid parameter' do
    it 'should show all post' do
      controller = PostController.new
      params = {
        "id": 1,
        "content": 'a',
        "attachment": '',
        "user_name": 'b',
        "related_id": ''
      }
      post = Post.new(params)
      posts = [post]
      expect(Post).to receive(:all_posts).and_return(posts)
      result = controller.index
      expected = '[{"id":1,"content":"a","attachment":"","user_name":"b","related_id":"","created_at":null}]'
      expect(result).to eq(expected)
    end
  end
end

describe '#show' do
  context 'if post found' do
    it 'should show 1 post if found and all the comments' do
      params = { "id": 1 }
      post_params = { "id": 1, "content": 'a', "attachment": '', "user_name": 'b', "related_id": '' }
      comment_params = { "id": 2, "content": 'a', "attachment": '', "user_name": 'b', "related_id": '' }
      new_comment = Post.new(comment_params)
      comments = [new_comment]
      controller = PostController.new
      expect(Post).to receive(:find_by_id).and_return(post_params)
      expect(Post).to receive(:find_comment_by_post_id).with(1).and_return(comments)
      result = controller.show(params)
      expected = '{"post":{"id":1,"content":"a","attachment":"","user_name":"b","related_id":""},"comment":[{"id":2,"content":"a","attachment":"","user_name":"b","related_id":"","created_at":null}]}'
      expect(result).to eq(expected)
    end
  end
end

context 'if post not found' do
  it 'should return nil' do
    params = { 'id' => 1 }

    controller = PostController.new

    expect(Post).to receive(:find_by_id).and_return(nil)

    result = controller.show(params)
    expected = nil

    expect(result).to eq(expected)
  end
end

describe '#show' do
  context 'if post found' do
    it 'should show 1 post if found and all the comments' do
      params = { "id": 1 }
      post_params = { "id": 1, "content": 'a', "attachment": '', "user_name": 'b', "related_id": '' }
      comment_params = { "id": 2, "content": 'a', "attachment": '', "user_name": 'b', "related_id": '' }
      new_comment = Post.new(comment_params)
      comments = [new_comment]
      controller = PostController.new
      expect(Post).to receive(:find_by_id).and_return(post_params)
      expect(Post).to receive(:find_comment_by_post_id).with(1).and_return(comments)
      result = controller.show(params)
      expected = '{"post":{"id":1,"content":"a","attachment":"","user_name":"b","related_id":""},"comment":[{"id":2,"content":"a","attachment":"","user_name":"b","related_id":"","created_at":null}]}'
      expect(result).to eq(expected)
    end
  end
end

context 'if post not found' do
  it 'should return nil' do
    params = { 'id' => 1 }

    controller = PostController.new

    expect(Post).to receive(:find_by_id).and_return(nil)

    result = controller.show(params)
    expected = nil

    expect(result).to eq(expected)
  end
end

