require "test_helper"

class Admin::CoffeeBrewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_coffee_brews_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_coffee_brews_edit_url
    assert_response :success
  end
end
