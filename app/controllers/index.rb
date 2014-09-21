enable :sessions

before '/:username/home' do
  @user = User.find_by(username: params[:username])
  session[:user_id] == @user.id ? @valid = true : @valid = false
end

get "/" do
  erb :index
end

get "/session" do
  if session[:error]
    @error = session[:error]
    session[:error] = nil
  end
  erb :'users/form'
end

post "/session" do
  user = User.authenticate(params[:username], params[:password])

  if user == nil || user == false
    session[:error] = "Login Failed"
    redirect "/session"
  else
    session[:user_id] = user.id
    redirect "/deck"
  end
end

post "/user" do
  user = User.new(params[:user])
  if user.valid?
    user.save
    redirect "/session"
  else
    session[:error] = user.errors.messages
    redirect "/user"
  end
end

get "/user" do
  if session[:error]
    @error = session[:error]
    session[:error] = nil
  end
  erb :'users/create_user'
end

get '/:username/home' do
  redirect '/session/new' if @valid == false
  erb :'users/landing_page'
end

# this is cheating. but how can we make an a href lead to a delete route?
get '/logout' do
  session.clear
  redirect :'/'
end



