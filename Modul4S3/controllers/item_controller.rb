require './models/item.rb'
require './models/category.rb'

class ItemController
    def create(params)
        item = Item.new(params)
        item.save
        
        # index
    end

    def index 
        items = Item.get_all
        renderer = ERB.new(File.read("./views/item_list.erb"))
        renderer.result(binding)
    end

    def update(params)
        item = Item.find_by_id(params["id"])
        if !item
            return false
        end
        item.name = params["name"]
        item.price = params["price"]
        item.category = params["category_id"]
        item.update

        # index
    end

    def delete(params)
        item = Item.find_by_id(params["id"])
        if !item
            return false
        end
        item.delete

        # index
    end

    def show(params)
        item = Item.new(
            params["id"],
            params["name"],
            params["price"],
            params["category"]
        )
        categories = Category.get_all
        renderer = ERB.new(File.read("./views/item_update.erb"))
        renderer.result(binding)
    end

    def add
        categories = Category.get_all
        renderer = ERB.new(File.read("./views/item_form.erb"))
        renderer.result(binding)
    end
end