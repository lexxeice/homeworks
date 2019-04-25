# autorization module
module Authorization
  def connect_to(api)
    api.add_user(self)
  end
end
