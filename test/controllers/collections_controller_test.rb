require 'test_helper'

class CollectionsControllerTest < ActionDispatch::IntegrationTest
  test 'Collections render show for each items' do
    Collection.all.each do |collection|
        get "/#{collection[:route]}"
        assert_response :success
    end
  end
end
