class Category < ApplicationRecord
  has_many :rooms,dependent: :destroy

  def self.looks(search, word)
    if search == "perfect_match"
      @category = Category.where("category_name LIKE?", "#{word}")
    elsif search == "partial_match"
      @category = Category.where("category_name LIKE?","%#{word}%")
    else
      @category = Category.all
    end
  end
end