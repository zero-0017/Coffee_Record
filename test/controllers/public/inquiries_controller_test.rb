require "test_helper"

class Public::InquiriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_inquiries_index_url
    assert_response :success
  end

  test "should get new" do
    get public_inquiries_new_url
    assert_response :success
  end

  test "should get show" do
    get public_inquiries_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_inquiries_edit_url
    assert_response :success
  end
end
