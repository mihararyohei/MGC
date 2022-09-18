class Message < ApplicationRecord
  validates :content, presence: true
  # after_create_commit { MessageBroadcastJob.perform_later self }
  belongs_to :customer
  belongs_to :room
end
