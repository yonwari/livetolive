class Place < ApplicationRecord
  has_many :events
  validates :place_name, presence: true, length: { maximum: 80 }
  validates :address, presence: true
end
