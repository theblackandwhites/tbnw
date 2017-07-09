class Event < ApplicationRecord
  belongs_to :calender
  belongs_to :event_item
end
