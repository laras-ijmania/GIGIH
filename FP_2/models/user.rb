require 'json'
require './db/mysql_connector'

class User
  attr_accessor :name, :bio, :created_at

  def initialize(params)
    @name = params[:name]
    @bio = params[:bio]
    @created_at = params[:created_at]
  end

  def valid?
    !(@name.nil? || @bio.nil?)
  end

  def save
    client = create_db_client
    client.query("INSERT INTO users (name, bio) VALUES ('#{@name}', '#{@bio}')")
  end
end
