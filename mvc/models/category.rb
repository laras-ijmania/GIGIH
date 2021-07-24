require "./db/mysql_connector.rb"

class Category
    attr_accessor :id, :name

    def initialize(id, name)
        @id = id
        @name = name
    end

    def save
        client = create_db_client
        statement = client.prepare("INSERT INTO categories (name) VALUES (?)")
        result = statement.execute(@name)
    end

    def self.get_all
        @client = create_db_client
        rawData = @client.query("SELECT * from categories")
        categories = Array.new
        rawData.each do |data|
            category = Category.new(data["id"], data["name"])
            categories.push(category)
        end
        categories
    end

    def self.find_by_id(id)
        client = create_db_client
        statement = client.prepare("select * from categories where id = ?")
        result = statement.execute(id)
        return nil unless result.count > 0
        data = result.first
        Category.new(data['id'], data['name'])
    end

    def update
        client = create_db_client
        statement = client.prepare("UPDATE categories SET name=? WHERE id = ?")
        result = statement.execute(@name, @id)
    end

    def delete
        client = create_db_client
        statement = client.prepare("UPDATE item_categories SET category_id=1 WHERE category_id = ?")
        result = statement.execute(@id)
        statement = client.prepare("DELETE FROM categories WHERE id = ?")
        result = statement.execute(@id)
    end
end