require './db/mysql_connector'
require '././models/post'

describe 'valid?' do
  context 'given valid parameter' do
    it 'should return true' do
      post = Post.new({
                        id: 1,
                        content: 'a',
                        attachment: '',
                        user_name: 'b',
                        related_id: '',
                        created_at: ''
                      })
      expect(post.valid?).to eq(true)
    end
  end

  context 'given invalid parameter' do
    it 'should return false when content nil' do
      post = Post.new({ user_name: '' })
      expect(post.valid?).to eq(false)
    end
  end

  context 'given invalid parameter' do
    it 'should return false when user+name nil' do
      post = Post.new({ content: 'a' })
      expect(post.valid?).to eq(false)
    end
  end
end

describe 'comment?' do
  context 'if relatedId not null' do
    it 'return true' do
      post = Post.new({
                        id: 1,
                        content: 'a',
                        attachment: '',
                        user_name: 'b',
                        related_id: 2,
                        created_at: ''
                      })
      expect(post.comment?).to eq(true)
    end
  end
end

describe 'save' do
  context 'when executed' do
    it 'should save post' do
      stub_client = double
      stub_query = "INSERT INTO posts (content, attachment, user_name, related_id) VALUES ('a', 'aaaa', 'b', 1)"
      post = Post.new({ content: 'a', attachment: 'aaaa', user_name: 'b', related_id: 1 })
      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query)
      post.save
    end
  end
end

describe 'save' do
  context 'when no attachment' do
    it 'should save post without attachment' do
      stub_client = double
      stub_query = "INSERT INTO posts (content, user_name, related_id) VALUES ('a', 'b', 1)"
      post = Post.new({ content: 'a', user_name: 'b', related_id: 1 })
      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query)
      post.save
    end
  end
end

describe 'save' do
  context 'when not a comment' do
    it 'should save post without related_id' do
      stub_client = double
      stub_query = "INSERT INTO posts (content, attachment, user_name) VALUES ('a', 'aaaa', 'b')"
      post = Post.new({
                        content: 'a',
                        attachment: 'aaaa',
                        user_name: 'b'
                      })
      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query)
      post.save
    end
  end
end

describe 'save' do
  context 'when no attachment and not a comment' do
    it 'should save post without attachment and related_d' do
      stub_client = double
      stub_query = "INSERT INTO posts (content, user_name) VALUES ('a', 'b')"
      post = Post.new({
                        content: 'a',
                        user_name: 'b'
                      })
      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query)
      post.save
    end
  end
end

describe 'get all' do
  context 'when executed' do
    it 'should return all posts and comments' do
      stub_client = double
      stub_query = 'SELECT id, content, attachment, user_name, created_at FROM posts p ORDER BY created_at desc'
      posts = [{ "id": 1, "content": 'a', "attachment": '', "user_name": 'b', "created_at": '' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(posts)

      result = Post.all
      expect(result).not_to be_nil
    end
  end
end

describe 'get all posts' do
  context 'when executed' do
    it 'should return all posts' do
      stub_client = double
      stub_query = 'SELECT id, content, attachment, user_name, created_at FROM posts p WHERE p.related_id IS NULL ORDER BY created_at desc'
      posts = [{ "id": 1, "content": 'a', "attachment": '', "user_name": 'b', "created_at": '' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(posts)

      result = Post.all_posts
      expect(result).not_to be_nil
    end
  end
end

describe 'is post by id' do
  context 'when executed' do
    it 'should return true if found' do
      stub_client = double
      stub_query = 'SELECT id FROM posts WHERE id = 1 AND related_id IS NULL'
      posts = [{ "id": 1, "content": 'a', "attachment": '', "user_name": 'b', "created_at": '' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(posts)

      result = Post.post_by_id?(1)
      expect(result).to eq(true)
    end
  end
end

describe 'find posts by id' do
  context 'when id found' do
    it 'should return 1 post' do
      stub_client = double
      stub_query = 'SELECT id, content, attachment, user_name, created_at FROM posts WHERE id = 1'
      posts = [{ "id": 1, "content": 'a', "attachment": '', "user_name": 'b', "created_at": '' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(posts)

      result = Post.find_by_id('1')
      expect(result).not_to be_nil
    end
  end
end

describe 'get all comment by post id' do
  context 'when executed' do
    it 'should return all comment on 1 post' do
      stub_client = double
      stub_query = 'SELECT id, content, attachment, user_name, related_id, created_at FROM posts p WHERE p.related_id = 1'
      posts = [{ "id": 2, "content": 'a', "attachment": '', "user_name": 'b', "related_id": 1, "created_at": '' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(posts)

      result = Post.find_comment_by_post_id(1)
      expect(result).not_to be_nil
    end
  end
end

describe 'find by content' do
  context 'when executed' do
    it 'should return all posts and comments with content' do
      stub_client = double
      stub_query = "SELECT id, content, attachment, user_name, related_id, created_at FROM posts p WHERE p.content like '%test%'"
      posts = [{ "id": 2, "content": 'test', "attachment": '', "user_name": 'b', "related_id": 1, "created_at": '' }]

      allow(Mysql2::Client).to receive(:new).and_return(stub_client)
      expect(stub_client).to receive(:query).with(stub_query).and_return(posts)

      result = Post.find_by_content('test')
      expect(result).not_to be_nil
    end
  end
end