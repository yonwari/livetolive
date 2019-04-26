class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #関連付け
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :favorites, dependent: :destroy
  has_many :calendar_events, dependent: :destroy
  has_many :events, through: :calendar_events
  has_many :notifications, dependent: :destroy

  #バリデーション
  validates :user_name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  # Googleログインでのユーザー存在確認
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        password: Devise.friendly_token[0, 20],
        user_name: auth.info.name,
        )
    end
    user
  end

  #本日開催のカレンダー登録イベントがあるかをチェック
  def have_today_events?
    events.today.exists?
  end

  #本日開催の通知があるかをチェック
  def notificated?
    notifications.exists?
  end
  #本日開催の通知を作成
  def make_notification
    today_events = events.today
    if today_events
      today_events.each do |event|
        Notification.create(user_id: self.id, event_id: event.id)
      end
    end
  end
end
