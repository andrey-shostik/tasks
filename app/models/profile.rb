class Profile < ActiveRecord::Base
  belongs_to :user

  # validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  def name
    "#{first_name} #{last_name}"
  end
end
