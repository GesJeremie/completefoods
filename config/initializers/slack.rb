CompleteFoods.configure do |config|
  config.slack = {
    webhook_url: Rails.application.credentials[:slack][:webhook_url]
  }
end
