require 'test_helper'

class PollOptionSetsControllerTest < ActionController::TestCase
  setup do
    @poll_option_set = poll_option_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poll_option_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poll_option_set" do
    assert_difference('PollOptionSet.count') do
      post :create, :poll_option_set => @poll_option_set.attributes
    end

    assert_redirected_to poll_option_set_path(assigns(:poll_option_set))
  end

  test "should show poll_option_set" do
    get :show, :id => @poll_option_set.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @poll_option_set.to_param
    assert_response :success
  end

  test "should update poll_option_set" do
    put :update, :id => @poll_option_set.to_param, :poll_option_set => @poll_option_set.attributes
    assert_redirected_to poll_option_set_path(assigns(:poll_option_set))
  end

  test "should destroy poll_option_set" do
    assert_difference('PollOptionSet.count', -1) do
      delete :destroy, :id => @poll_option_set.to_param
    end

    assert_redirected_to poll_option_sets_path
  end
end
