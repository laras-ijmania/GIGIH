# twitter2
***Because every masterpiece has their cheap copy***

Twitter2 is a copy of tw*tter, where people can register as user, make some posts and also leave comment on the post.

To be able to create post and comment, the user must be registered at twitter2 by inserting their username and bio. Each username must be unique.

Each post or comment is limited to 1000 characters, and can also contain file attachment. Each post or comment might contain hashtag, which twitter2 can analyze and see which hashtag is trending in 24 hours.

## Prerequisite
### 1. Ruby with Rbenv
### 2. MySql
### 3. Gem :
- sinatra
- mysql2
- sinatra-namespace
- dotenv
- puma
- json
- rspec
- simplecov

## How to run the app
1. Install all the prerequisites
2. Clone the git repository with `git clone git@github.com:laras-ijmania/GIGIH.git`
3. Go to the local repository, and then to `FP_2` folder
4. To run the test suite, run `rspec`
5. To run the app, run `ruby app.rb`. The backend gonna run on `http://localhost:4567`