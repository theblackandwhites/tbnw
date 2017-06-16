class Hack < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
end
