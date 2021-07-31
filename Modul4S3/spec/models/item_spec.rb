require './db/mysql_connector'
require '././models/item.rb'

describe Item do
    describe 'valid?' do
        context 'given valid parameter' do
            it 'should return true' do
                item = Item.new({
                    id: 1, 
                    name: "a", 
                    price: 1000, 
                    category: 1
                })
                expect(item.valid?).to eq(true)
            end
        end
    
        context 'given invalid parameter' do
            it 'should return false when price nil' do
                item = Item.new({id: 1, name: "a"})
                expect(item.valid?).to eq(false)
            end
        end

        context 'given invalid parameter' do
            it 'should return false when name nil' do
                item = Item.new({id: 1, price: 1000})
                expect(item.valid?).to eq(false)
            end
        end
    end

    describe 'update' do
        context 'when executed' do
            it 'should change data' do
                stub_client = double
                stub_query_1 ="UPDATE item_categories SET category_id=1 WHERE item_id = 1"
                stub_query_2 ="UPDATE items SET name=a, price=1000 WHERE id = 1"
                item = Item.new({
                    id: 1, 
                    name: "a", 
                    price: 1000, 
                    category: 1
                })
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query_1)
                expect(stub_client).to receive(:query).with(stub_query_2)
                item.update()
            end
        end
    end

    describe 'save' do
        context 'when executed' do
            it 'should save data' do
                stub_client = double
                stub_query = "INSERT INTO items (name, price) VALUES (a, 1000)"
                item = Item.new({
                    id: 1, 
                    name: "a", 
                    price: 1000, 
                    category: 1
                })
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query)
                item.save()
            end
        end
    end

    describe 'delete' do
        context 'when executed' do
            it 'should delete data' do
                stub_client = double
                stub_query = "DELETE FROM order_items WHERE item_id = 1"
                stub_query_2 = "DELETE FROM item_categories WHERE item_id = 1"
                stub_query_3 = "DELETE FROM items WHERE id = 1"
                item = Item.new({
                    id: 1, 
                    name: "a", 
                    price: 1000, 
                    category: 1
                })
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query)
                expect(stub_client).to receive(:query).with(stub_query_2)
                expect(stub_client).to receive(:query).with(stub_query_3)
                item.delete()
            end
        end
    end

    describe 'get all' do
        context 'when executed' do
            it 'should return all data' do
                stub_client = double
                stub_query = "SELECT items.id as id, items.name as name, items.price as price, categories.name as category_name, categories.id as category_id FROM items JOIN item_categories JOIN categories WHERE items.id = item_categories.item_id and categories.id = item_categories.category_id"
                items = [{"id": 1, "name": "a", "price": 1000, "category_id": 1, "category_name": "b"}]

                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return(items)
                
                getItem = Item.get_all
                expect(getItem).not_to be_nil
            end
        end
    end

    describe 'find by id' do
        context 'when data found' do
            it 'should return exactly 1 data' do
                stub_client = double
                stub_query = "select * from (select * from items where id = 1) item inner join item_categories on item_id = item.id"
                items = [{"id": 1, "name": "a", "price": 1000, "category_id": 1, "category_name": "b"}]

                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return(items)
                
                foundItem = Item.find_by_id(1)
                expect(foundItem).not_to be_nil
            end
        end

        context 'when data not found' do
            it 'should return empty' do
                stub_client = double
                stub_query = "select * from (select * from items where id = 1) item inner join item_categories on item_id = item.id"
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return([])
                foundItem = Item.find_by_id(1)
                expect(foundItem).to eq(nil)
            end
        end
    end

    describe 'find by category id' do
        context 'when data found' do
            it 'should return all data with category id' do
                stub_client = double
                stub_query = "select * from items inner join item_categories on items.id = item_categories.item_id where item_categories.category_id = 1"
                items = [{"id": 1, "name": "a", "price": 1000, "category": 1}]

                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return(items)
                
                foundItem = Item.find_by_category(1)
                expect(foundItem).not_to be_nil
            end
        end
    end

    describe 'find by category id' do
        context 'when data not found' do
            it 'should return empty' do
                stub_client = double
                stub_query = "select * from items inner join item_categories on items.id = item_categories.item_id where item_categories.category_id = 1"
                items = []

                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return(items)
                
                foundItem = Item.find_by_category(1)
                expect(foundItem).to eq(nil)
            end
        end
    end
end