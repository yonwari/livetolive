class Event < ApplicationRecord
  # 関連付け
  has_one_attached :event_image
  has_many :calendar_events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :event_comedians
  has_many :comedians, through: :event_comedians
  belongs_to :place

  # バリデーション
  validates :event_title, presence:true,length: { maximum: 100 }
  validates :start_date, presence:true
  validates :end_date, presence: true
  validates :explanation, presence:true,length: { maximum: 200 }
  validates :reserve_url, presence: true
  validates :open_date, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  def calendared_by?(user)
    calendar_events.where(user_id: user.id).exists?
  end
end
