require "test_helper"

class Admin::ChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_chats_new_url
    assert_response :success
  end

  test "should get index" do
    get admin_chats_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_chats_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_chats_edit_url
    assert_response :success
  end
end
