class Inquiry < ApplicationRecord
  attr_accessor :name, :email, :message

  validates :name, length: { maximum: 30 }, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true, length: { maximum: 200 }
end
