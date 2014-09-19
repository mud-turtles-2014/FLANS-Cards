class User < ActiveRecord::Base
  has_many :decks
  has_many :cards, through: :decks
  has_many :deck_tags, through: :decks
  has_many :tags, through: :deck_tags
  has_many :rounds
  has_many :guesses, through: :rounds
  has_secure_password

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    return user.authenticate(password) unless user == nil
    nil
  end
end
