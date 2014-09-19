class Tag < ActiveRecord::Base
  belongs_to :deck_tags
  has_many :decks, through: :deck_tags
  has_many :cards, through: :decks
  has_many :rounds, through: :deck
  has_many :guesses, through: :cards
  has_many :users, through: :guesses
end
