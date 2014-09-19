class Card < ActiveRecord::Base
  belongs_to :deck
  has_one :user, through: :deck
  has_many :deck_tags, through: :deck
  has_many :tags, through: :deck
  has_many :guesses
  has_many :rounds, through: :deck
  has_many :playsheets, through: :rounds
end
