class Notification < ApplicationRecord
  validates :date, :title, :description, presence: true
end
