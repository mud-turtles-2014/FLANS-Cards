class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :playsheets
  has_many :cards, through: :deck
  has_many :deck_tags, through: :deck
  has_many :tags, through: :deck_tags
  has_many :guesses, through: :cards
end
