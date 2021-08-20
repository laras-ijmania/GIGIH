require '././db/mysql_connector'
require '././controllers/user_controller'
require '././models/user'

class UserController
  def create(params)
    user = User.new(params)
    return false unless user.valid?

    user.save
  end

  def index
    users = User.all
    users.to_json
  end
end