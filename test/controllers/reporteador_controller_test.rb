require 'test_helper'

class ReporteadorControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get view_base" do
    get :view_base
    assert_response :success
  end

end
