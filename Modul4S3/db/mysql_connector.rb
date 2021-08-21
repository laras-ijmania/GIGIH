# frozen_string_literal: true

# require 'dotenv'
# Dotenv.load
require 'mysql2'
require './models/category'
require './models/item'

def create_db_client
  @client = Mysql2::Client.new(
    host: 'localhost',
    # username: ENV['DB_USERNAME'],
    # password: ENV['DB_PASSWORD'],
    # database: ENV['DB_NAME']

    username: 'root',
    password: '',
    database: 'food_oms_db'
  )
  @client
end
