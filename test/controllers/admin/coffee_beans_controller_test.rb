require "test_helper"

class Admin::CoffeeBeansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_coffee_beans_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_coffee_beans_edit_url
    assert_response :success
  end
end
