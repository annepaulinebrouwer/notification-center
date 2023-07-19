class Notification < ApplicationRecord
  has_many :user_notifications, dependent: :destroy
  has_many :users, through: :user_notifications

  validates :date, :title, :description, presence: true
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    return unless date.present? && date < Date.today

    errors.add(:date, "can't be in the past")
  end
end
