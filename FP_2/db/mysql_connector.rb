require 'dotenv/load'
require 'mysql2'

def create_db_client
  @client = Mysql2::Client.new(
    host: 'localhost',
    username: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_NAME']
  )
  @client
end