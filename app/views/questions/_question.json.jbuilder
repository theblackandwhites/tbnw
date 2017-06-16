json.extract! question, :id, :user_id, :category_id, :body, :created_at, :updated_at
json.url question_url(question, format: :json)
