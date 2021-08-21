# Twitter2
***Because every masterpiece has their cheap copy***

Twitter2 is a copy of tw*tter, where people can register as user, make some posts and also leave comment on the post.

To be able to create posts and comments, the user must be registered at twitter2 by inserting their username and bio. Each username must be unique.

Each post or comment is limited to 1000 characters, and can also contains file attachment. Each post or comment might contain hashtag, which twitter2 can analyze and see which hashtag is trending in 24 hours.

## Prerequisite
1. Ruby with Rbenv 
2. MySQL
## Gem Dependencies
- gem install sinatra
- gem install mysql2
- gem install sinatra-namespace
- gem install dotenv
- gem install puma
- gem install json
- gem install rspec
- gem install simplecov

# Instructions

## Project Preparation
1. Install all the prerequisites and dependencies
2. Clone the git repository with `git clone git@github.com:laras-ijmania/GIGIH.git`
3. Go to the local repository, and then to `FP_2` folder
## Database Preparation
1. Go to `documentations` folder
2. Run `mysql -u [username] -p`
3. Insert password
4. Create a new database. Run `create database [database_name]`
5. Import database schema by running `[database_name] < sql

## Run the app and test suite locally
1. To run the test suite, run `rspec`
2. To run the app, run `ruby app.rb`. The backend gonna run on `http://localhost:4567`

## Run API in GCP Server
You can also see the API in GCP server.
Address : http://104.199.135.201:4567 