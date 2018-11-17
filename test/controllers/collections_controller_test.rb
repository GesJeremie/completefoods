require 'test_helper'

class CollectionsControllerTest < ActionDispatch::IntegrationTest
  test 'collections routes are being redirected when no products available' do
    Rails.configuration.collections.each do |collection|
        get "/#{collection[:route]}"
        assert_response :redirect
    end
  end
end
