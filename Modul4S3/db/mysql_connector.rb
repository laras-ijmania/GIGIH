require 'mysql2'
require './models/category.rb'
require './models/item.rb'

def create_db_client
    @client = Mysql2::Client.new(
        :host => "localhost",
        :username => ENV["DB_USERNAME"],
        :password => ENV["DB_PASWORD"],
        :database => ENV["DB_NAME"]
    )
    @client
end