class Room < ApplicationRecord
  has_many :messages,dependent: :destroy

  has_many :bookmarks
  has_many :customers, through: :bookmarks,dependent: :destroy

  has_many :customer_rooms
  has_many :customers, through: :customer_rooms,dependent: :destroy

  belongs_to :category

  has_one_attached :room_image

  validates :room_name, presence: true

  # delegate :category_name, to: :category

  def get_room_image
    (room_image.attached?) ? room_image : 'no_image.jpg'
  end

  def bookmarked_by?(customer)
    bookmarks.exists?(customer_id: customer.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @room = Room.where("room_name LIKE?", "#{word}")
    elsif search == "partial_match"
      @room = Room.where("room_name LIKE?","%#{word}%")
    else
      @room = Room.all
    end
  end
end