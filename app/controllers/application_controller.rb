require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "f650ed69344bab0084199bb8cc9aa5a1bd6756c3b57ad67023255af0fc3795057e"
  end

  get "/" do
    erb :welcome
  end

  get '/signup' do
    if !session[:id] #if its false
    erb :'users/signup' 
    #I want my user to go to sign up page so redirect them to users/signup
    else
      redirect '/books/new'
    end 
  end
  
  post '/signup' do 
    # i want my user's request to be processed and sent to /signup ??
    if user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id 
    flash[:notice] = "Thanks for signing up!"

    redirect '/books/new'
    else 
    redirect '/'
    end
  
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
  user = User.find_by(email: params[:email].strip)
  if user != nil && user.authenticate(params[:password])
    session[:user_id] = user.id 
        redirect '/books'
    else
      redirect '/login'
    end 
  end

  get '/logout' do 
    session.clear
    redirect '/login'
  end

  helpers do
    def current_user
      @user = User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

end


end
