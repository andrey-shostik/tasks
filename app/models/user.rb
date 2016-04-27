class User < ActiveRecord::Base
  has_secure_token
  has_secure_password

  has_many :items, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_one :profile, dependent: :destroy

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }
end
