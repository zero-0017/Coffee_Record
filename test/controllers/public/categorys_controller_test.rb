# frozen_string_literal: true

require "test_helper"

class Public::CategorysControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_categorys_show_url
    assert_response :success
  end
end
