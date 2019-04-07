class EventComedian < ApplicationRecord
  validates  :event_id, presence: true
  validates  :comedian_id,   presence: true
  belongs_to :event
  belongs_to :comedian
end
