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

  #scope
  scope :from_now, -> { where('start_date >= ?', DateTime.now) }
  scope :today, -> { where(start_date: DateTime.now.all_day) }
  scope :recent, -> { order("start_date ASC") }

  # お気に入り、カレンダー登録チェック
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  def calendared_by?(user)
    calendar_events.where(user_id: user.id).exists?
  end

  # 開催日までの日数を返却
  def from_now_to_start_date
    today = Date.today
    start = Date.parse(self.start_date.to_s)
    start - today
  end

  # 芸人タグ付け用
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
end
