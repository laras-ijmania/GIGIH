require '././db/mysql_connector'
require '././controllers/item_controller'
require '././models/item'
require '././models/category'

describe ItemController do
    describe "#create" do
        context "given valid parameter" do
            it "make a new item" do
                stub = double
                
                controller = ItemController.new
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "price"=> 1000,
                    "category"=>1
                }
    
                expect(Item).to receive(:new).with(params).and_return(stub)
                expect(stub).to receive(:valid?).and_return(true)
                expect(stub).to receive(:save)
    
                controller.create(params)

                expect(Item).to receive(:find_by_id).with(1).and_return(stub)
                result_item = Item.find_by_id(1)
                expect(result_item).not_to be_nil
            end
        end

        context "given invalid parameter" do
            it "should return false" do
                stub = double
                
                controller = ItemController.new
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "price"=> 1000,
                    "category"=>1
                }
    
                expect(Item).to receive(:new).with(params).and_return(stub)
                expect(stub).to receive(:valid?).and_return(nil)
    
                result = controller.create(params)

                expect(result).to eq(false)
            end
        end
    end

    describe "#index" do
        context "given valid parameter" do
            it "should show all item" do
                controller = ItemController.new

                allow(Item).to receive(:get_all).and_return([])
                allow(Item).to receive(:get_all).and_return([])

                result = controller.index
                items = Item.get_all
                expected_view = ERB.new(File.read('././views/item_list.erb')).result(binding)

                expect(result).to eq(expected_view)
            end
        end
    end

    describe "#update" do
        context "given valid parameter" do
            it "should return true" do
                stub = double
                
                controller = ItemController.new
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "price"=> 1000,
                    "category"=>1
                }
                stub_query_1 = 'UPDATE item_categories SET category_id=1 WHERE item_id = 1'
                stub_query_2 = 'UPDATE items SET name=a, price=1000 WHERE id = 1'

                item = Item.new({
                    id: 1,
                    name: 'a',
                    price: 1000,
                    category: 1
                  })
                allow(Mysql2::Client).to receive(:new).and_return(stub)
                expect(Item).to receive(:find_by_id).with(1).and_return(item)
                expect(stub).to receive(:query).with(stub_query_1)
                expect(stub).to receive(:query).with(stub_query_2)

                result = controller.update(params)
                expect(result).to eq(true)
            end
        end

        context "given item id not found" do
            it "should return false" do
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "price"=> 1000,
                    "category"=>1
                }
                expect(Item).to receive(:find_by_id).with(1).and_return(nil)

                controller = ItemController.new

                result = controller.update(params)

                expect(result).to be(false)
            end
        end
    end

    describe "#delete" do
        context "given valid item id" do
            it "item should not be found after delete" do
                stub = double
                params = {
                    "id"=> 1
                }
                item = Item.new({
                    id: 1,
                    name: 'a',
                    price: 1000,
                    category: 1
                  })

                stub_query = 'DELETE FROM order_items WHERE item_id = 1'
                stub_query_2 = 'DELETE FROM item_categories WHERE item_id = 1'
                stub_query_3 = 'DELETE FROM items WHERE id = 1'

                allow(Mysql2::Client).to receive(:new).and_return(stub)
                expect(Item).to receive(:find_by_id).with(1).and_return(item)
                expect(stub).to receive(:query).with(stub_query)
                expect(stub).to receive(:query).with(stub_query_2)
                expect(stub).to receive(:query).with(stub_query_3)
                expect(Item).to receive(:find_by_id).with(1).and_return(nil)

                controller = ItemController.new

                controller.delete(params)

                result = Item.find_by_id(1)

                expect(result).to be_nil

            end
        end

        context "given invalid item id" do
            it "should return false" do
                stub = double
                params = {
                    "id"=> 1
                }

                allow(Mysql2::Client).to receive(:new).and_return(stub)
                expect(Item).to receive(:find_by_id).with(1).and_return(nil)

                controller = ItemController.new

                result = controller.delete(params)

                expect(result).to eq(false)
            end
        end
    end

    describe "#show" do
        context "given valid parameter" do
            it "should show item" do
                controller = ItemController.new
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "price"=> 1000,
                    "category"=>1
                }

                expect(Category).to receive(:get_all).and_return([])
                expect(Category).to receive(:get_all).and_return([])

                result = controller.show(params)

                item = Item.new({
                    id: 1,
                    name: 'a',
                    price: 1000,
                    category: 1
                })
                categories = Category.get_all
                expected_view = ERB.new(File.read('././views/item_update.erb')).result(binding)
                expect(result).to eq(expected_view)
            end
        end

        context "given invalid parameter" do
            it "should return false" do
                controller = ItemController.new
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "category"=>1
                }
                
                result = controller.show(params)
                expect(result).to eq(false)
            end
        end
    end

    describe "#add" do
        context "new item" do
            it "should show form for adding item" do
                stub = double
                
                controller = ItemController.new

                allow(Category).to receive(:get_all).and_return([])
                allow(Category).to receive(:get_all).and_return([])

                result = controller.add
                categories = Category.get_all
                expected_view = ERB.new(File.read('././views/item_form.erb')).result(binding)

                expect(result).to eq(expected_view)
            end
        end
    end
end