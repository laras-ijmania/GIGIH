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

  def self.all
    @client = create_db_client
    raw_data = @client.query('SELECT u.name as name, u.bio as bio, u.created_at as created_at FROM users u')
    users = []
    raw_data.each do |data|
      user = User.new({ "name": data['name'], "bio": data['bio'], "created_at": data['created_at'] })
      users.push(user)
    end
    users
  end

  def self.user_by_name?(name)
    client = create_db_client
    result = client.query("select name from users where name = '#{name}'")
    if result.count.positive?
      true
    else
      false
    end
  end

  def self.find_by_name(name)
    client = create_db_client
    result = client.query("select * from users where name = '#{name}'")
    return nil unless result.count.positive?

    data = result.first
    User.new({
               "name": data['name'],
               "bio": data['bio'],
               "created_at": data['created_at']
             })
  end

  def update
    client = create_db_client
    client.query("UPDATE users SET bio='#{@bio}' WHERE name = '#{@name}'")
  end

  def delete
    client = create_db_client
    client.query("DELETE FROM users WHERE name = '#{@name}'")
  end
  
  def to_json(*args)
    {
      'name' => @name,
      'bio' => @bio,
      'created_at' => @created_at
    }.to_json(*args)
  end
end