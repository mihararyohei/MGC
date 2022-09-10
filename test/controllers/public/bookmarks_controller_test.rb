require "test_helper"

class Public::BookmarksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_bookmarks_new_url
    assert_response :success
  end
end
