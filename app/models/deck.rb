class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  has_many :deck_tags
  has_many :tags, through: :deck_tags
  has_many :rounds
  has_many :guesses, through: :rounds
  has_many :playsheets, through: :rounds

  def random_answers(card)
  	answers = [card.back]
  	until answers.length == 4
  	  random = self.cards.sample 
  	  answers << random.back if !answers.include?(random.back)
  	end
  	answers.shuffle
  end

end
