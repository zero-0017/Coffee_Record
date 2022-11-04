# frozen_string_literal: true

require "test_helper"

class Admin::PostCoffeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_coffees_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_post_coffees_show_url
    assert_response :success
  end
end
