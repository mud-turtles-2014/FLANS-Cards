class Playsheet < ActiveRecord::Base
  belongs_to :round
  belongs_to :card
  has_one :deck, through: :round
  has_one :user, through: :round
  has_one :tag, through: :deck


  def self.create_round_play(round, deck)
    deck.cards.shuffle.each do |card|
      Playsheet.create(round: round, card: card)
    end
  end

end
