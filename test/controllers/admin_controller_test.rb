require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get panel" do
    get :panel
    assert_response :success
  end

  test "should get customers" do
    get :customers
    assert_response :success
  end

  test "should get create_customer" do
    get :create_customer
    assert_response :success
  end

  test "should get edit_customer" do
    get :edit_customer
    assert_response :success
  end

  test "should get delete_customer" do
    get :delete_customer
    assert_response :success
  end

  test "should get view_all_pages" do
    get :view_all_pages
    assert_response :success
  end

end
