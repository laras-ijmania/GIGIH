require 'sinatra'
require 'sinatra/namespace'
require './controllers/user_controller'
require './controllers/post_controller'

get '/' do
    return 'Hello world'
  end
  
  before do
    content_type 'application/json'
  end
  
  namespace '/users' do
    controller = UserController.new
  
    get '' do
      controller.index
    end
  
    get '/:name' do
      controller.show(params)
    end
  
    post '' do
      controller.create(params)
    end
  end
  
  namespace '/posts' do
    controller = PostController.new
  
    get '' do
      controller.index
    end
  
    get '/:id' do
      controller.show(params)
    end
  
    post '' do
      controller.create(params)
    end
  end
  
  namespace '/trending' do
    controller = PostController.new
  
    get '' do
      controller.trending
    end
  end
  
  namespace '/search' do
    controller = PostController.new
  
    get '/:str' do
      controller.search(params)
    end
  end
  