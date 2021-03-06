

get '/deck/:deck_id/multiple' do
  # main thing being done is creating round? if so, put in round model
  deck = Deck.find(params[:deck_id])
  user = User.find(session[:user_id]) # is session accessible in a model?

  round = Round.create(user: user, deck: deck, last_position: 1)
  Playsheet.create_round_play(round, deck)

  card = round.playsheets[round.last_position].card #this could be in round
  session[:round_id] = round.id
  redirect "/deck/#{deck.id}/multiple/card/#{card.id}"
end

# before showing a card, check to see whether it's been played
# using the round's playsheet
# if it has, go to the first card in the playsheet that hasn't
# been answered
# then can redirect to same route
get '/deck/:deck_id/multiple/card/:card_id' do
  @deck = Deck.find(params[:deck_id])
  @user = User.find(session[:user_id])
  @card = Card.find(params[:card_id])
  @round = Round.find(session[:round_id])
  @answers = @deck.random_answers(@card)

  if session[:played]
    @played = true
    session[:played] = false
    @answer = @card.back
    @user_answer = session[:answer]
    @user_answer == @answer ? @correct = true : @correct = false
    session[:answer] = nil
    Guess.create(card: @card, round: @round, correct: @correct)
  end

  if @round.playsheets[@round.last_position] != nil
    @next_card = @round.playsheets[@round.last_position].card
  else
    @finish = true
  end
  erb :card_multiple
end

post '/deck/:deck_id/multiple/card/:card_id' do

  session[:played] = true
  session[:answer] = params[:answer]

  @deck = Deck.find(params[:deck_id])
  @user = User.find(session[:user_id])
  @card = Card.find(params[:card_id])
  @round = Round.find(session[:round_id])

  @round.last_position += 1
  @round.save

  redirect "/deck/#{@deck.id}/multiple/card/#{@card.id}"
end

