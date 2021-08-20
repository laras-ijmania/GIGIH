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
end