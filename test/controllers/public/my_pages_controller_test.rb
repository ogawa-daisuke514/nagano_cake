require "test_helper"

class Public::MyPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_my_pages_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_my_pages_edit_url
    assert_response :success
  end

  test "should get withdraw_confirm" do
    get public_my_pages_withdraw_confirm_url
    assert_response :success
  end
end
