require 'test_helper'

class UnsignedColumnsTestsControllerTest < ActionController::TestCase
  setup do
    @unsigned_columns_test = unsigned_columns_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unsigned_columns_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unsigned_columns_test" do
    assert_difference('UnsignedColumnsTest.count') do
      post :create, unsigned_columns_test: { boolean_unsigned_column: @unsigned_columns_test.boolean_unsigned_column, decimal_unsigned_column: @unsigned_columns_test.decimal_unsigned_column, integer_unsigned_column: @unsigned_columns_test.integer_unsigned_column, unsigned_float_column: @unsigned_columns_test.unsigned_float_column }
    end

    assert_redirected_to unsigned_columns_test_path(assigns(:unsigned_columns_test))
  end

  test "should show unsigned_columns_test" do
    get :show, id: @unsigned_columns_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unsigned_columns_test
    assert_response :success
  end

  test "should update unsigned_columns_test" do
    put :update, id: @unsigned_columns_test, unsigned_columns_test: { boolean_unsigned_column: @unsigned_columns_test.boolean_unsigned_column, decimal_unsigned_column: @unsigned_columns_test.decimal_unsigned_column, integer_unsigned_column: @unsigned_columns_test.integer_unsigned_column, unsigned_float_column: @unsigned_columns_test.unsigned_float_column }
    assert_redirected_to unsigned_columns_test_path(assigns(:unsigned_columns_test))
  end

  test "should destroy unsigned_columns_test" do
    assert_difference('UnsignedColumnsTest.count', -1) do
      delete :destroy, id: @unsigned_columns_test
    end

    assert_redirected_to unsigned_columns_tests_path
  end
end
