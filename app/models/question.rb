class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :reply_answers, dependent: :destroy

def self.search(search)
  where("title LIKE ?", "%#{search}%") 
  where("body LIKE ?", "%#{search}%")
end

end

