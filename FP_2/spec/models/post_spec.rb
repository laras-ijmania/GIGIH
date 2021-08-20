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