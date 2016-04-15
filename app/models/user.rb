class User < ActiveRecord::Base
  has_secure_token
  has_secure_password

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # validates :first_name, :last_name, length: { minimum: 3 }
  validates :login, uniqueness: true

  has_many :items, dependent: :destroy
  has_many :accounts, dependent: :destroy

  def name
    "#{last_name} #{first_name}"
  end
end
