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
end