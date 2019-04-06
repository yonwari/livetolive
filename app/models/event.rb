class Event < ApplicationRecord
  has_one_attached :event_image
  has_many :calender_events
  has_many :favorites
  has_many :event_comedians
  has_many :comedians, through: :event_comedians
  belongs_to :place

  validates :event_title, presence:true,length: { maximum: 100 }
  validates :start_date, presence:true
  validates :end_date, presence: true
  validates :explanation, presence:true,length: { maximum: 200 }
  validates :reserve_url, presence: true
  validates :open_date, presence: true
end
