class Comedian < ApplicationRecord
  has_many :event_comedians
  has_many :events, through: :event_comedians
end
