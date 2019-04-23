# autorization module
module Authorization
  attr_reader :connection_status, :login

  def connect_to_api(api)
    api.add_user(self)
    @login = api
    user_connected!(true)
  end

  def user_connected!(status)
    @connection_status = status
  end

  def user_connected?
    @connection_status ? true : (puts 'User not logged in!')
  end
end
