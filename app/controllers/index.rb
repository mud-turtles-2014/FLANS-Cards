enable :sessions

before '/:username/home' do
  @user = User.find_by(username: params[:username])
  session[:user_id] == @user.id ? @valid = true : @valid = false
end

get "/" do
  erb :index
end

get "/session/new" do
  erb :'users/form'
end

post "/session" do
  user = User.authenticate(params[:username], params[:password])

  if user == nil
    redirect "/session/new"
  end

  unless user == nil
    session[:user_id] = user.id
    redirect "/#{user.username}/home"
  end
end

post "/user/create" do
  user = User.new(params[:user])
  user.save
  redirect "/session/new"
end

get "/user/new" do
  erb :'users/create_user'
end

get '/:username/home' do
  redirect '/session/new' if @valid == false
  erb :'users/landing_page'
end

delete '/session' do
  session.clear
  erb :logout
end

