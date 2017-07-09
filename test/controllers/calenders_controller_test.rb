require 'test_helper'

class CalendersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calender = calenders(:one)
  end

  test "should get index" do
    get calenders_url
    assert_response :success
  end

  test "should get new" do
    get new_calender_url
    assert_response :success
  end

  test "should create calender" do
    assert_difference('Calender.count') do
      post calenders_url, params: { calender: { intro: @calender.intro, month: @calender.month } }
    end

    assert_redirected_to calender_url(Calender.last)
  end

  test "should show calender" do
    get calender_url(@calender)
    assert_response :success
  end

  test "should get edit" do
    get edit_calender_url(@calender)
    assert_response :success
  end

  test "should update calender" do
    patch calender_url(@calender), params: { calender: { intro: @calender.intro, month: @calender.month } }
    assert_redirected_to calender_url(@calender)
  end

  test "should destroy calender" do
    assert_difference('Calender.count', -1) do
      delete calender_url(@calender)
    end

    assert_redirected_to calenders_url
  end
end
