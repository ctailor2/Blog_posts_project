enable :sessions

get '/' do
  # Look in app/views/index.erb
  initialize_session
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  email = params[:email]
  password = params[:password]

  if User.exists?(email)
    user = User.authenticate(email, password)
    if user
      send(:current_user=, user)
      redirect to('/')
    else
      @errors = {"password" => "incorrect"}
      erb :login
    end
  else
    @errors = {"email" => "does not exist, please register"}
    erb :login
  end
end

get '/register' do
  erb :register
end

post '/register' do
  @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
  if @user.valid?
    redirect to('/login')
  else
    @errors = @user.errors
    erb :register
  end
end

post '/logout' do
  logout
  redirect to ('/posts')
end
