require './models/item.rb'

class CategoryController
    def create(params)
        category = Category.new(
            params["id"],
            params["name"],
        )
        category.save
    end

    def index 
        categories = Category.get_all
        renderer = ERB.new(File.read("./views/category_list.erb"))
        renderer.result(binding)
    end

    def add
        renderer = ERB.new(File.read("./views/category_form.erb"))
        renderer.result(binding)
    end

    def update(params)
        category = Category.find_by_id(params["id"])
        category.name = params["name"]
        category.update

        index
    end

    def delete(params)
        category = Category.find_by_id(params["id"])
        category.delete

        index
    end

    def show(params)
        category = Category.new(
            params["id"],
            params["name"]
        )
        items = Item.find_by_category(params["id"])
        renderer = ERB.new(File.read("./views/category.erb"))
        renderer.result(binding)
    end
end