# frozen_string_literal: true

require "test_helper"

class Admin::CoffeeCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_coffee_comments_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_coffee_comments_show_url
    assert_response :success
  end
end
