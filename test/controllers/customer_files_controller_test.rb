require 'test_helper'

class CustomerFilesControllerTest < ActionController::TestCase
  test "should get shared" do
    get :shared
    assert_response :success
  end

  test "should get audio_search" do
    get :audio_search
    assert_response :success
  end

  test "should get audio_selected" do
    get :audio_selected
    assert_response :success
  end

end
