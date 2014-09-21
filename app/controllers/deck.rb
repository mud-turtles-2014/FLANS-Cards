enable :sessions

before '/deck*' do
  redirect '/session' unless session[:user_id]
end

before '/user*' do
  redirect '/session' unless session[:user_id]
end

get '/deck' do
  @decks = Deck.all
  erb :deck
end

get '/deck/:deck_id' do
  # main thing being done is creating round? if so, put in round model
  deck = Deck.find(params[:deck_id])
  user = User.find(session[:user_id]) # is session accessible in a model?

  round = Round.create(user: user, deck: deck, last_position: 1)
  Playsheet.create_round_play(round, deck)

  card = round.playsheets[round.last_position].card #this could be in round
  session[:round_id] = round.id
  redirect "/deck/#{deck.id}/card/#{card.id}"
end

# before showing a card, check to see whether it's been played
# using the round's playsheet
# if it has, go to the first card in the playsheet that hasn't
# been answered
# then can redirect to same route
get '/deck/:deck_id/card/:card_id' do
  @deck = Deck.find(params[:deck_id])
  @user = User.find(session[:user_id])
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
  @user = User.find(session[:user_id])
  @card = Card.find(params[:card_id])
  @round = Round.find(session[:round_id])

  @round.last_position += 1
  @round.save

  redirect "/deck/#{@deck.id}/card/#{@card.id}"
end

get '/deck/:deck_id/score' do
  @round = Round.find(session[:round_id])
  total = @round.guesses.count
  puts "" * 5
  p "*"*50
  puts "SCORING NOW IN get '/deck/:deck_id/score' do ROUTE"
  puts "@round.guesses: #{@round.guesses}"

  @score = (@round.guesses.select { |guess| guess.correct == true }).count.to_f/total * 100

  puts "score: #{@score}"

  @round.update(score: @score)
  session[:round] = nil

  erb :score
end

