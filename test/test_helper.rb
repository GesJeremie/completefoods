ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# To add Capybara feature tests add `gem 'minitest-rails-capybara'`
# to the test group in the Gemfile and uncomment the following:
# require 'minitest/rails/capybara'

# Uncomment for awesome colorful output
require 'minitest/pride'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def self.prepare
    # Add code that needs to be executed before test suite start
  end
  prepare

  def setup
    CryptoCurrency.create(symbol: 'BTC', name: 'Bitcoin')
    CryptoCurrency.create(symbol: 'STR', name: 'Stellar')
    Currency.create(symbol: 'EUR', name: 'Euro')
    Currency.create(symbol: 'USD', name: 'United States Dollar')

    # Add code that need to be executed before each test
  end

  def teardown
    # Add code that need to be executed after each test
  end
end
