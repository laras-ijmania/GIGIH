require '././db/mysql_connector'
require '././controllers/item_controller.rb'
require '././models/item.rb'

describe ItemController do
    let(:client) { MySQLDB.get_client }
    describe "create" do
        context "valid parameter" do
            it "make a new item" do
                stub = double
                
                controller = ItemController.new
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "price"=> 1000,
                    "category"=>1
                }
                item = Item.new({
                    id: 1, 
                    name: "a", 
                    price: 1000, 
                    category: 1
                })
    
                expect(Item).to receive(:new).with(params).and_return(stub)
                expect(stub).to receive(:save)
    
                response = controller.create(params)

                expect(Item).to receive(:find_by_id).with(1).and_return(item)
                expected_order = Item.find_by_id(1)
                expect(expected_order).not_to be_nil

            end
        end
    end

    describe "update" do
        context "invalid parameter" do
            it "should return false" do
                params = {
                    "id"=> 1,
                    "name"=> "a",
                    "price"=> 1000,
                    "category"=>1
                }
                expect(Item).to receive(:find_by_id).with(1).and_return(false)

                controller = ItemController.new

                response = controller.update(params)

                expect(response).to be(false)
            end
        end
    end
end