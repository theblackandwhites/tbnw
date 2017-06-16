class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :reply_answers, dependent: :destroy
end
