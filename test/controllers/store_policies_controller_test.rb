require 'test_helper'

class StorePoliciesControllerTest < ActionController::TestCase
  setup do
    @store_policy = store_policies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:store_policies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store_policy" do
    assert_difference('StorePolicy.count') do
      post :create, store_policy: { content: @store_policy.content, name: @store_policy.name }
    end

    assert_redirected_to store_policy_path(assigns(:store_policy))
  end

  test "should show store_policy" do
    get :show, id: @store_policy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store_policy
    assert_response :success
  end

  test "should update store_policy" do
    patch :update, id: @store_policy, store_policy: { content: @store_policy.content, name: @store_policy.name }
    assert_redirected_to store_policy_path(assigns(:store_policy))
  end

  test "should destroy store_policy" do
    assert_difference('StorePolicy.count', -1) do
      delete :destroy, id: @store_policy
    end

    assert_redirected_to store_policies_path
  end
end
