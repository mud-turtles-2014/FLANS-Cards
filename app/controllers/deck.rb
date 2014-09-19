enable :sessions


get '/deck' do
  @decks = Deck.all
  erb :deck
end

get '/deck/:deck_id' do
  session[:id] = 1
  @deck = Deck.find(params[:deck_id])
  @user = User.find(session[:id]) #make sure Alex defined this way

  @round = Round.create(user: @user, deck: @deck, last_position: 1)
  Playsheet.create_round_play(@round, @deck)

  card = @round.playsheets[@round.last_position].card
  session[:round_id] = @round.id
  redirect "/deck/#{@deck.id}/card/#{card.id}"
end

get '/deck/:deck_id/card/:card_id' do
  @deck = Deck.find(params[:deck_id])
  @user = User.find(session[:id])
  @card = Card.find(params[:card_id])
  @round = Round.find(session[:round_id])

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
  erb :card
end

post '/deck/:deck_id/card/:card_id' do

  session[:played] = true
  session[:answer] = params[:answer]

  @deck = Deck.find(params[:deck_id])
  @user = User.find(session[:id])
  @card = Card.find(params[:card_id])
  @round = Round.find(session[:round_id])

  @round.last_position += 1
  @round.save

  redirect "/deck/#{@deck.id}/card/#{@card.id}"
end

get '/deck/:deck_id/score' do
  @round = Round.find(session[:round_id])
  total = @round.guesses.count
  @score = (@round.guesses.select { |guess| guess.correct == true }).count.to_f/total * 100
  @round.update(score: @score)
  puts "**********************************"
  p @round.guesses
  erb :score
end

