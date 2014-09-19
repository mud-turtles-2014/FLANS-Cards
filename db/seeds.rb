alex = User.create(name: "Alex Ung", username:"alex",password:"alex",password_confirmation:"alex")

eng_to_span = Deck.create(name: "English to Spanish", user: alex)

card1 = Card.create(front:"one", back:"uno", deck: eng_to_span)
card2 = Card.create(front:"two", back:"dos", deck: eng_to_span)
card3 = Card.create(front:"three", back:"tres", deck: eng_to_span)
card4 = Card.create(front:"four", back:"cuatro", deck: eng_to_span)
card5 = Card.create(front:"five", back:"cinco", deck: eng_to_span)
card6 = Card.create(front:"six", back:"seis", deck: eng_to_span)

lang = Tag.create(name:"language")

DeckTag.create(deck: eng_to_span, tag: lang)

round = Round.create(user: alex, deck: eng_to_span, score: 90)

guess1 = Guess.create(card: card1, round: round, correct: true)
guess2 = Guess.create(card: card2, round: round, correct: false)
guess3 = Guess.create(card: card3, round: round, correct: true)
guess4 = Guess.create(card: card4, round: round, correct: true)


Playsheet.create_round_play(round, eng_to_span)
