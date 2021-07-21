require 'mysql2'
require_relative 'item'
require_relative 'category'

def create_db_client
    @client = Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "",
        :database => "food_oms_db"
    )
    @client
end

def get_item_categories
    @client = create_db_client
    rawData = @client.query(
        "SELECT items.id as id, items.name as name, items.price as price, categories.name as category_name, categories.id as category_id
        FROM items JOIN item_categories JOIN categories 
        WHERE items.id = item_categories.item_id and categories.id = item_categories.category_id"
    )
    items = Array.new
    rawData.each do |data|
        category = Category.new(data["category_id"], data["category_name"])
        item = Item.new(data["id"], data["name"], data["price"], category)
        items.push(item)
    end
    items
end

def insert_item_categories(name, price, category_id)
    @client = create_db_client
    @client.query("INSERT INTO items (name,price) VALUES ('#{name}', #{price})")
    
    id = @client.last_id
    @client.query("INSERT INTO item_categories (item_id, category_id) VALUES (#{id}, #{category_id})")
end

def update_item_categories(item_id, new_name, new_price, new_categories)
    @client = create_db_client
    @client.query("UPDATE item_categories SET category_id='#{new_categories}' WHERE item_id = #{item_id}")
    @client.query("UPDATE items SET name ='#{new_name}', price = #{new_price} WHERE id = #{item_id}")
end

def delete_item_categories(item_id)
    @client = create_db_client
    @client.query("DELETE FROM item_categories WHERE item_id = #{item_id}")
    @client.query("DELETE FROM items WHERE id = #{item_id}")
end

def get_all_items
    @client = create_db_client
    rawData = @client.query("SELECT * from items")
    items = Array.new
    rawData.each do |data|
        item = Item.new(data["id"], data["name"], data["price"])
        items.push(item)
    end
    items
end

def get_all_categories
    @client = create_db_client
    rawData = @client.query("SELECT * from categories")
    categories = Array.new
    rawData.each do |data|
        category = Category.new(data["id"], data["name"])
        categories.push(category)
    end
    categories
end

def insert_item(name, price)
    @client = create_db_client
    @client.query("INSERT INTO items (name,price) VALUES ('#{name}', #{price})")
end

def get_item_price(price)
    @client = create_db_client
    rawData = @client.query("SELECT items.name as name, items.price as price, categories.name as category FROM items JOIN item_categories JOIN categories WHERE items.id = item_categories.item_id and categories.id = item_categories.category_id and price < #{price}")
    items = Array.new
    rawData.each do |data|
        item = Category.new(data["id"], data["name"])
        items.push(item)
    end
    items
end

item_categories = get_item_categories
puts (item_categories.each)
puts "-------------------------------------------"

item_price = get_item_price(18000)
puts (item_price.each)
puts "-------------------------------------------"


items = get_all_items
puts (items.each)