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
end