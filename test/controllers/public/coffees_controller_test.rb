# frozen_string_literal: true

require "test_helper"

class Public::CoffeesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_coffees_show_url
    assert_response :success
  end
end
