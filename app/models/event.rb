class Event < ApplicationRecord
  # 関連付け
  has_one_attached :event_image
  has_many :calendar_events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :event_comedians, dependent: :destroy
  has_many :comedians, through: :event_comedians
  has_many :notifications, dependent: :destroy
  belongs_to :place

  # バリデーション
  validates :event_title, presence:true,length: { maximum: 100 }
  validates :start_date, presence:true
  validates :end_date, presence: true
  validates :explanation, presence:true,length: { maximum: 200 }
  validates :reserve_url, presence: true
  validates :open_date, presence: true
  validate :validate_event_image
  validate :validate_past_datetime

  #scope
  scope :from_now, -> { where('start_date >= ?', Time.zone.now) }
  scope :today, -> { where(start_date: Time.zone.now.all_day) }
  scope :recent, -> { order("start_date ASC") }

  #芸人タグ付け用
  #DBへのコミット直前に実施する
  after_create do
    event = Event.find_by(id: self.id)
    if event.comedianlist.present?
      comedians  = self.comedianlist.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      comedians.uniq.map do |comedian|
        #ハッシュタグは先頭の'#'を外した上で保存
        tag = Comedian.find_or_create_by(comedian_name: comedian.delete('#'))
        event.comedians << tag
      end
    end
  end

  before_update do
    event = Event.find_by(id: self.id)
    event.comedians.clear
    if event.comedianlist.present?
      comedians = self.comedianlist.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      comedians.uniq.map do |comedian|
        tag = Comedian.find_or_create_by(comedian_name: comedian.delete('#'))
        event.comedians << tag
      end
    end
  end

  #過去日付のバリデーション
  def validate_past_datetime
    if open_date.present? && open_date.past?
      errors.add(:open_date, "に過去の日付を入力することはできません。")
    end
    if start_date.present? && start_date.past?
      errors.add(:start_date, "に過去の日付を入力することはできません。")
    end
    if end_date.present? && end_date.past?
      errors.add(:end_date, "に過去の日付を入力することはできません。")
    end
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "を開始日時より過去または同時刻に設定することはできません。")
    end
    if start_date.present? && open_date.present? && start_date <= open_date
      errors.add(:open_date, "を開始日時より未来または同時刻に設定することはできません。")
    end
  end

  #画像のバリデーション
  def validate_event_image
    return unless event_image.attached?
    if event_image.blob.byte_size > 30.megabytes
      event_image.purge
      errors.add(:event_image, '画像サイズが大きすぎます')
    elsif !image?
      event_image.purge
      errors.add(:event_image, '画像の拡張子はjpg,jpeg,gif,pngのみ選択可能です')
    end
  end
  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(event_image.blob.content_type)
  end

  # お気に入り、カレンダー登録チェック
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  def calendared_by?(user)
    calendar_events.where(user_id: user.id).exists?
  end

  # 開催日までの日数を返却
  def from_now_to_start_date
    today = Date.parse(Time.zone.now.to_s)
    start = Date.parse(self.start_date.to_s)
    start - today
  end
end
