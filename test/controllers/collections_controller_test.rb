require 'test_helper'

class CollectionsControllerTest < ActionDispatch::IntegrationTest
  test 'show each collection' do
    Collection.all.each do |collection|
        get collection_path(collection.slug)
        assert_response :success
    end
  end
end
