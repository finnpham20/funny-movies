module RequestSpecHelper
  def login_with(user)
    post '/login', params: { email: user.email, password: user.password }
    follow_redirect!
  end
end

RSpec.configure do |config|
  config.include RequestSpecHelper
end
