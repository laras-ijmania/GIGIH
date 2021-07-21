require 'sinatra'
require_relative './db_connector'

get '/' do
    return 'Hello world'
end

get '/items' do
    items = get_item_categories
    categories = get_all_categories

    erb :item_list, locals: {
        items: items,
        categories: categories
    }
end

post '/item_delete' do
    item_id = params['item_id']
    delete_item_categories(item_id)
    redirect '/items'
end

get '/item_update_form' do
    name = params['name']
    price = params['price']
    category = params['category']

    items = get_item_categories
    categories = get_all_categories

    erb :item_update, locals: {
        name: name,
        price: price,
        category: category
    }
end

post '/item_update' do
    item_id = params['item_id']
    new_name = params['new_name']
    new_price = params['new_price']
    new_categories = params['new_categories']

    update_item_categories(item_id, new_name, new_price, new_categories)
    return "item updated"
end

post '/items' do
    name = params['name']
    price = params['price']
    category_id = params['category_id']

    items = get_item_categories
    categories = get_all_categories

    insert_item_categories(name, price, category_id)

    redirect '/items'
end

get '/items_form' do
    items = get_item_categories
    categories = get_all_categories

    erb :items_form, locals: {
        items: items,
        categories: categories
    }
end

