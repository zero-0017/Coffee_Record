# frozen_string_literal: true

require "test_helper"

class Public::CoffeeBeansControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_coffee_beans_show_url
    assert_response :success
  end
end
