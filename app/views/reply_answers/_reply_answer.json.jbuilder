json.extract! reply_answer, :id, :body, :user_id, :question_id, :answer_id, :created_at, :updated_at
json.url reply_answer_url(reply_answer, format: :json)
