require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get dashboard_dashboard_url
    assert_response :success
  end

  test "should get invoices" do
    get dashboard_invoices_url
    assert_response :success
  end

  test "should get billing" do
    get dashboard_billing_url
    assert_response :success
  end

  test "should get your_questions" do
    get dashboard_your_questions_url
    assert_response :success
  end

  test "should get your_answers" do
    get dashboard_your_answers_url
    assert_response :success
  end

end
