require 'test_helper'

class ExpendituresControllerTest < ActionController::TestCase
  setup do
    @expenditure = expenditures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expenditures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expenditure" do
    assert_difference('Expenditure.count') do
      post :create, :expenditure => @expenditure.attributes
    end

    assert_redirected_to expenditure_path(assigns(:expenditure))
  end

  test "should show expenditure" do
    get :show, :id => @expenditure.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @expenditure.to_param
    assert_response :success
  end

  test "should update expenditure" do
    put :update, :id => @expenditure.to_param, :expenditure => @expenditure.attributes
    assert_redirected_to expenditure_path(assigns(:expenditure))
  end

  test "should destroy expenditure" do
    assert_difference('Expenditure.count', -1) do
      delete :destroy, :id => @expenditure.to_param
    end

    assert_redirected_to expenditures_path
  end
end
