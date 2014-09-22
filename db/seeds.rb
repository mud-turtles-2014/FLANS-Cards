alex = User.create(name: "Alex Ung", username:"alex",password:"alex",password_confirmation:"alex")
steph = User.create(name: "Steph Zhang", username:"steph",password:"steph",password_confirmation:"steph")
nic = User.create(name: "Nicolle Quintero", username:"nicolle",password:"nicolle",password_confirmation:"nicolle")

eng_to_span = Deck.create(name: "English to Spanish", user: alex)
state_capitals = Deck.create(name: "State Capitals", user: nic)
theme_songs = Deck.create(name:"90s TV Show Theme Songs", user: steph)

card1 = Card.create(front:"Blue", back:"azul", deck: eng_to_span)
card2 = Card.create(front:"Ten", back:"diez", deck: eng_to_span)
card3 = Card.create(front:"Man", back:"hombre", deck: eng_to_span)
card4 = Card.create(front:"Please", back:"por favor", deck: eng_to_span)
card5 = Card.create(front:"Daughter", back:"hija", deck: eng_to_span)
card6 = Card.create(front:"Telephone", back:"teléfono", deck: eng_to_span)

lang = Tag.create(name:"language")

DeckTag.create(deck: eng_to_span, tag: lang)

round = Round.create(user: alex, deck: eng_to_span, score: 90)
round = Round.create(user: alex, deck: theme_songs, score: 100)
round = Round.create(user: alex, deck: eng_to_span, score: 100)
round = Round.create(user: alex, deck: state_capitals, score: 80)

card7 = Card.create(front:"It's a rare condition, this day and age / To read any good news on the newspaper page", back:"Family Matters", deck: theme_songs)
card8 = Card.create(front:"I don't want to wait for our lives to be over", back:"Dawson's Creek", deck: theme_songs)
card9 = Card.create(front:"So no one told you life was gonna be this way / Your job's a joke, you're broke, your love life's D.O.A.", back:"Friends", deck: theme_songs)
card10 = Card.create(front:"Now, this is the story all about how / My life got flipped-turned upside down", back:"Fresh Prince of Bel-air", deck: theme_songs)
card11 = Card.create(front:"When I wake up in the morning / And the alarm gives out a warning", back:"Saved by the Bell", deck: theme_songs)


card12 = Card.create(front:"Idaho", back:"Boise", deck: state_capitals)
card13= Card.create(front:"Kansas", back:"Topeka", deck: state_capitals)
card14 = Card.create(front:"New Jersey", back:"Trenton", deck: state_capitals)
card15 = Card.create(front:"Wisconsin", back:"Madison", deck: state_capitals)
card16 = Card.create(front:"New Mexico", back:"Santa Fe", deck: state_capitals)
