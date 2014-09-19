class Guess < ActiveRecord::Base
  belongs_to :card
  belongs_to :round
  has_one :user, through: :round
  has_one :deck, through: :card
  has_many :deck_tags, through: :decks
  has_many :tags, through: :deck_tags
  has_one :playsheet, through: :round
end
