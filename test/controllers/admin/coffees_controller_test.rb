# frozen_string_literal: true

require "test_helper"

class Admin::CoffeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_coffees_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_coffees_edit_url
    assert_response :success
  end
end
