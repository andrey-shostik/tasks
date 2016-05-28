class Item < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, :due_date, presence: true

  def completed?
    !completed_at.blank?
  end
end
