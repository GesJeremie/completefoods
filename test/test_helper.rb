ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Add factories
Dir[Rails.root.join('test/factories/**/*.rb')].each { |file| require file }

class ActiveSupport::TestCase
  def self.prepare
    Rails.application.load_seed
  end
  prepare

  def setup
    # Add code that need to be executed before each test
  end

  def teardown
    # Add code that need to be executed after each test
  end

  def create(factory, arguments = {})
    get_factory(factory).new(arguments).create
  end

  def build(factory, arguments = {})
    get_factory(factory).new(arguments).build
  end

  private

    def get_factory(factory)
      Object.const_get(
        factory.to_s.split('_').map(&:capitalize).join << 'Factory'
      )
    end
end
