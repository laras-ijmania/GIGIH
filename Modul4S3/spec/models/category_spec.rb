require './db/mysql_connector'
require '././models/category.rb'

describe Category do
    describe 'valid?' do
        context 'given valid parameter' do
            it 'should return true' do
                category = Category.new({
                    id: 1, 
                    name: "a"
                })
                expect(category.valid?).to eq(true)
            end
        end
    
        context 'given invalid parameter' do
            it 'should return false when name nil' do
                category = Category.new({id: 1})
                expect(category.valid?).to eq(false)
            end
        end
    end

    describe 'update' do
        context 'when executed' do
            it 'should change data' do
                stub_client = double
                stub_query_1 ="UPDATE categories SET name=a WHERE id = 1"
                category = Category.new({
                    id: 1, 
                    name: "a"
                })
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query_1)
                category.update()
            end
        end
    end

    describe 'save' do
        context 'when executed' do
            it 'should save data' do
                stub_client = double
                stub_query = "INSERT INTO categories (name) VALUES (a)"
                category = Category.new({
                    id: 1, 
                    name: "a"
                })
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query)
                category.save()
            end
        end
    end

    describe 'delete' do
        context 'when executed' do
            it 'should delete data' do
                stub_client = double
                stub_query = "UPDATE item_categories SET category_id=1 WHERE category_id = 1"
                stub_query_2 = "DELETE FROM categories WHERE id = 1"
                category = Category.new({
                    id: 1, 
                    name: "a"
                })
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query)
                expect(stub_client).to receive(:query).with(stub_query_2)
                category.delete()
            end
        end
    end

    describe 'get all' do
        context 'when executed' do
            it 'should return all data' do
                stub_client = double
                stub_query = "SELECT * from categories"
                categories = [{"id": 1, "name": "a"}]

                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return(categories)
                
                getCategory = Category.get_all
                expect(getCategory).not_to be_nil
            end
        end
    end

    describe 'find by id' do
        context 'when data found' do
            it 'should return exactly 1 data' do
                stub_client = double
                stub_query = "select * from categories where id = 1"
                categories = [{"id": 1, "name": "a"}]

                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return(categories)
                
                foundCategory = Category.find_by_id(1)
                expect(foundCategory).not_to be_nil
            end
        end

        context 'when data not found' do
            it 'should return empty' do
                stub_client = double
                stub_query = "select * from categories where id = 1"
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(stub_query).and_return([])
                foundCategory = Category.find_by_id(1)
                expect(foundCategory).to eq(nil)
            end
        end
    end
end