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