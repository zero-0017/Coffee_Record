# frozen_string_literal: true

require "test_helper"

class Public::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_contacts_index_url
    assert_response :success
  end

  test "should get new" do
    get public_contacts_new_url
    assert_response :success
  end

  test "should get show" do
    get public_contacts_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_contacts_edit_url
    assert_response :success
  end

  test "should get thank" do
    get public_contacts_thank_url
    assert_response :success
  end
end
