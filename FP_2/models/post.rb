# frozen_string_literal: true

# rubocop:disable Layout/LineLength

# rubocop:disable Metrics/MethodLength

require './db/mysql_connector'

# Post is class for post
class Post
  attr_accessor :id, :content, :attachment, :user_name, :related_id, :created_at

  def initialize(params)
    @id = params[:id]
    @content = params[:content]
    @attachment = params[:attachment] || nil
    @user_name = params[:user_name]
    @related_id = params[:related_id] || nil
    @created_at = params[:created_at]
  end

  def valid?
    !(@content.nil? || @user_name.nil?)
  end

  def comment?
    !@related_id.nil?
  end

  def save
    client = create_db_client
    if @attachment.nil? && @related_id.nil?
      client.query("INSERT INTO posts (content, user_name) VALUES ('#{@content}', '#{@user_name}')")
    elsif @attachment.nil?
      client.query("INSERT INTO posts (content, user_name, related_id) VALUES ('#{@content}', '#{@user_name}', #{@related_id})")
    elsif @related_id.nil?
      client.query("INSERT INTO posts (content, attachment, user_name) VALUES ('#{@content}', '#{@attachment}', '#{@user_name}')")
    else
      client.query("INSERT INTO posts (content, attachment, user_name, related_id) VALUES ('#{@content}', '#{@attachment}', '#{@user_name}', #{@related_id})")
    end
    true
  end

  def self.all
    @client = create_db_client
    raw_data = @client.query('SELECT id, content, attachment, user_name, created_at FROM posts p ORDER BY created_at desc')
    posts = []
    raw_data.each do |data|
      post = Post.new({ "id": data['id'], "content": data['content'], "attachment": data['attachment'], "user_name": data['user_name'], "related_id": data['related_id'], "created_at": data['created_at'] })
      posts.push(post)
    end
    posts
  end

  def self.all_posts
    @client = create_db_client
    raw_data = @client.query('SELECT id, content, attachment, user_name, created_at FROM posts p WHERE p.related_id IS NULL ORDER BY created_at desc')
    posts = []
    raw_data.each do |data|
      post = Post.new({ "id": data['id'], "content": data['content'], "attachment": data['attachment'], "user_name": data['user_name'], "related_id": data['related_id'], "created_at": data['created_at'] })
      posts.push(post)
    end
    posts
  end

  def self.post_by_id?(id)
    @client = create_db_client
    result = @client.query("SELECT id FROM posts WHERE id = #{id} AND related_id IS NULL")
    result.count.positive?
  end

  def self.find_by_id(id)
    @client = create_db_client
    result = @client.query("SELECT id, content, attachment, user_name, created_at FROM posts WHERE id = #{id}")
    return nil unless result.count.positive?

    data = result.first
    Post.new({ "id": data['id'], "content": data['content'], "attachment": data['attachment'], "user_name": data['user_name'], "created_at": data['created_at'] })
  end

  def self.find_comment_by_post_id(id)
    @client = create_db_client
    raw_data = @client.query("SELECT id, content, attachment, user_name, related_id, created_at FROM posts p WHERE p.related_id = #{id}")
    return nil unless raw_data.count.positive?

    posts = []
    raw_data.each do |data|
      post = Post.new({ "id": data['id'], "content": data['content'], "attachment": data['attachment'], "user_name": data['user_name'], "related_id": data['related_id'], "created_at": data['created_at'] })
      posts.push(post)
    end
    posts
  end

  def self.find_by_content(str)
    @client = create_db_client
    raw_data = @client.query("SELECT id, content, attachment, user_name, related_id, created_at FROM posts p WHERE p.content like '%#{str}%'")
    return nil unless raw_data.count.positive?

    posts = []
    raw_data.each do |data|
      post = Post.new({ "id": data['id'], "content": data['content'], "attachment": data['attachment'], "user_name": data['user_name'], "related_id": data['related_id'], "created_at": data['created_at'] })
      posts.push(post)
    end
    posts
  end
end