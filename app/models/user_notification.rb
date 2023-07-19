class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  scope :not_seen, -> { where(seen: false) }
end
