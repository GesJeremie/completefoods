require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CompleteFoods
  class Application < Rails::Application
    config.load_defaults 5.1
    config.middleware.use Rack::Deflater
  end

  def self.config
    Rails.configuration.x
  end

  def self.configure
    yield(config)
  end
end
