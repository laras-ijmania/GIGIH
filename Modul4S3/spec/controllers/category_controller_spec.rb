require '././db/mysql_connector'
require '././controllers/category_controller'
require '././models/item'
require '././models/category'

describe CategoryController do
    describe "#create" do
        context "given valid parameter" do
            it "make a new category" do
                stub = double
                
                controller = CategoryController.new
                params = {
                    "id"=> 1,
                    "name"=> "a"
                }
                category = Category.new(params)
    
                expect(Category).to receive(:new).with(params).and_return(stub)
                expect(stub).to receive(:valid?).and_return(true)
                expect(stub).to receive(:save)
                expect(Category).to receive(:find_by_id).with(1).and_return(category)
    
                controller.create(params)

                result = Category.find_by_id(1)
                expect(result).not_to be_nil
            end
        end

        context "given invalid parameter" do
            it "should return false" do
                stub = double
                
                controller = CategoryController.new
                params = {
                    "id"=> 1
                }
                category = Category.new(params)
    
                expect(Category).to receive(:new).with(params).and_return(stub)
                expect(stub).to receive(:valid?).and_return(false)
    
                result = controller.create(params)

                expect(result).to eq(false)
            end
        end
    end

    describe "#index" do
        context "given valid parameter" do
            it "should show all category" do
                controller = CategoryController.new

                expect(Category).to receive(:get_all).and_return([])
                expect(Category).to receive(:get_all).and_return([])

                result = controller.index
                categories = Category.get_all
                expected_view = ERB.new(File.read('././views/category_list.erb')).result(binding)

                expect(result).to eq(expected_view)
            end
        end
    end

    describe "#add" do
        context "new item" do
            it "should return form" do
                controller = CategoryController.new
                result = controller.add
                expected = ERB.new(File.read('././views/category_form.erb')).result(binding)

                expect(result).to eq(expected)
            end
        end
    end

    describe "#update" do
        context "given valid parameter" do
            it "should return true" do
                stub = double
                
                controller = CategoryController.new
                params = {
                    "id"=> 1,
                    "name"=> "a"
                }
                stub_query_1 = "UPDATE categories SET name=a WHERE id = 1"

                category = Category.new({
                    "id": 1,
                    "name": "a"
                })
                allow(Mysql2::Client).to receive(:new).and_return(stub)
                expect(Category).to receive(:find_by_id).with(1).and_return(category)
                expect(stub).to receive(:query).with(stub_query_1)

                result = controller.update(params)
                expect(result).to eq(true)
            end
        end

        context "invalid parameter" do
            it "should return false" do
                params = {
                    "id"=> 1,
                    "name"=> "a"
                }
                expect(Category).to receive(:find_by_id).with(1).and_return(nil)

                controller = CategoryController.new

                result = controller.update(params)

                expect(result).to be(false)
            end
        end
    end

    describe "#delete" do
        context "given valid category id" do
            it "category should not be found after delete" do
                stub = double
                params = {
                    "id"=> 1
                }
                category = Category.new({
                    id: 1,
                    name: 'a'
                })

                stub_query = "UPDATE item_categories SET category_id=1 WHERE category_id = 1"
                stub_query_2 = "DELETE FROM categories WHERE id = 1"
                allow(Mysql2::Client).to receive(:new).and_return(stub)
                expect(Category).to receive(:find_by_id).with(1).and_return(category)
                expect(stub).to receive(:query).with(stub_query)
                expect(stub).to receive(:query).with(stub_query_2)
                expect(Category).to receive(:find_by_id).with(1).and_return(nil)

                controller = CategoryController.new

                controller.delete(params)

                result = Category.find_by_id(1)

                expect(result).to be_nil
            end
        end

        context "given invalid category id" do
            it "should return false" do
                stub = double
                params = {
                    "id"=> 1
                }

                allow(Mysql2::Client).to receive(:new).and_return(stub)
                expect(Category).to receive(:find_by_id).with(1).and_return(nil)

                controller = CategoryController.new

                result = controller.delete(params)

                expect(result).to eq(false)
            end
        end
    end

    describe "#show" do
        context "given valid parameter" do
            it "should return category and list of item with corresponding category" do
                controller = CategoryController.new
                params = {
                    "id"=> 1,
                    "name"=> "a"
                }

                category = Category.new({
                    id: 1,
                    name: 'a'
                })
                
                stub_client = double
                stub_query = 'select * from items inner join item_categories on items.id = item_categories.item_id where item_categories.category_id = 1'

                expect(Item).to receive(:find_by_category).with(1).and_return([])
                expect(Item).to receive(:find_by_category).with(1).and_return([])

                result = controller.show(params)
                items = Item.find_by_category(1)
                expected_view = ERB.new(File.read('././views/category.erb')).result(binding)
                expect(result).to eq(expected_view)
            end
        end

        context "invalid parameter" do
            it "should return false" do
                controller = CategoryController.new
                params = {
                    "id"=> 1
                }
                
                result = controller.show(params)
                expect(result).to eq(false)
            end
        end
    end
end