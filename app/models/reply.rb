class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :hack
  belongs_to :comment
end
