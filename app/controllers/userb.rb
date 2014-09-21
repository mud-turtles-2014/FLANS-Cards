get '/user/:user_id' do
  @user = User.find(params[:user_id])
  @rounds = @user.rounds
  erb :"users/profile"
end
