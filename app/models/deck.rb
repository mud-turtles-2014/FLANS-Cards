class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  has_many :deck_tags
  has_many :tags, through: :deck_tags
  has_many :rounds
  has_many :guesses, through: :rounds
end
