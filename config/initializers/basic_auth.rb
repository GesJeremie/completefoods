CompleteFoods.configure do |config|
  config.basic_auth = {
    user: Rails.application.credentials[Rails.env.to_sym][:basic_auth][:user],
    password: Rails.application.credentials[Rails.env.to_sym][:basic_auth][:password],
  }
end
