class Room < ApplicationRecord
  belongs_to :customer
  belongs_to :communities
end
