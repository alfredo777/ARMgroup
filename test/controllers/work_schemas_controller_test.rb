require 'test_helper'

class WorkSchemasControllerTest < ActionController::TestCase
  setup do
    @work_schema = work_schemas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_schemas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_schema" do
    assert_difference('WorkSchema.count') do
      post :create, work_schema: { campaing_id: @work_schema.campaing_id, customer_id: @work_schema.customer_id, name: @work_schema.name }
    end

    assert_redirected_to work_schema_path(assigns(:work_schema))
  end

  test "should show work_schema" do
    get :show, id: @work_schema
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_schema
    assert_response :success
  end

  test "should update work_schema" do
    patch :update, id: @work_schema, work_schema: { campaing_id: @work_schema.campaing_id, customer_id: @work_schema.customer_id, name: @work_schema.name }
    assert_redirected_to work_schema_path(assigns(:work_schema))
  end

  test "should destroy work_schema" do
    assert_difference('WorkSchema.count', -1) do
      delete :destroy, id: @work_schema
    end

    assert_redirected_to work_schemas_path
  end
end
