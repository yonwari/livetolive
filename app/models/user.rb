class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #関連付け
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :favorites, dependent: :destroy
  has_many :calendar_events, dependent: :destroy
  has_many :events, through: :calendar_events

  #バリデーション
  validates :user_name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  # omniauthのコールバック時に呼ばれるメソッド
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.uid =      auth.uid,
  #     user.provider =  auth.provider,
  #     user.email = auth.info.email
  #     user.user_name = auth.info.name
  #     user.password = Devise.friendly_token[0,20]
  #   end
  # end
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
end
