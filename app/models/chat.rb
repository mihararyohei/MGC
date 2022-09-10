class Chat < ApplicationRecord
  has_many :communities, dependent: :destroy
  belongs_to :customer
  belongs_to :community
end
