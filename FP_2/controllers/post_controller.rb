require 'json'
require './models/post'
require './models/user'

class PostController
  def create(params)
    post = Post.new(params)
    return 'invalid post' unless post.valid?

    is_user = User.user_by_name?(params[:user_name])
    return 'user not found' unless is_user

    return 'post not found' if post.comment? && !Post.post_by_id?(post.relatedId)

    post.save ? 'post created' : 'post not created'
  end

  def index
    posts = Post.all_posts
    posts.to_json
  end

  def show(params)
    post = Post.find_by_id(params[:id])
    return if post.nil?

    comments = Post.find_comment_by_post_id(params[:id])
    object = { 'post' => post, 'comment' => comments }
    JSON[object]
  end

  def search(params)
    posts = Post.find_by_content(params[:str])
    posts.to_json
  end

  def trending
    posts = Post.all_one_day
    hashtag_count = Hash.new(0)
    posts.each do |post|
      hashtag_post = []
      post.content.split(' ').each do |word|
        next unless word =~ /#\w+/
        hashtag_post.push(word) unless hashtag_post.include?(word)
      end
      hashtag_post.each do |hashtag|
        hashtag_count[hashtag] += 1
      end
    end
    hashtag_count.sort_by { |_key, value| value }.reverse.to_h.to_json
  end
end