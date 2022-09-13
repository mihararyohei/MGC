class Community < ApplicationRecord
  has_many :messages
  has_many :rooms
  has_many :customers, through: :rooms
end
