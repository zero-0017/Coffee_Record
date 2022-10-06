require "test_helper"

class Admin::CategorysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_categorys_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_categorys_edit_url
    assert_response :success
  end
end
