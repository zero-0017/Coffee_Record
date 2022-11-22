# frozen_string_literal: true

require "test_helper"

class Public::CoffeeBrewsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_coffee_brews_show_url
    assert_response :success
  end
end
