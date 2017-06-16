require 'test_helper'

class ReplyAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reply_answer = reply_answers(:one)
  end

  test "should get index" do
    get reply_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_reply_answer_url
    assert_response :success
  end

  test "should create reply_answer" do
    assert_difference('ReplyAnswer.count') do
      post reply_answers_url, params: { reply_answer: { answer_id: @reply_answer.answer_id, body: @reply_answer.body, question_id: @reply_answer.question_id, user_id: @reply_answer.user_id } }
    end

    assert_redirected_to reply_answer_url(ReplyAnswer.last)
  end

  test "should show reply_answer" do
    get reply_answer_url(@reply_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_reply_answer_url(@reply_answer)
    assert_response :success
  end

  test "should update reply_answer" do
    patch reply_answer_url(@reply_answer), params: { reply_answer: { answer_id: @reply_answer.answer_id, body: @reply_answer.body, question_id: @reply_answer.question_id, user_id: @reply_answer.user_id } }
    assert_redirected_to reply_answer_url(@reply_answer)
  end

  test "should destroy reply_answer" do
    assert_difference('ReplyAnswer.count', -1) do
      delete reply_answer_url(@reply_answer)
    end

    assert_redirected_to reply_answers_url
  end
end
