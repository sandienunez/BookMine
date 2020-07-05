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
      redirect '/books'
    end 
  end
  
  post '/signup' do 
    #binding.pry 
    #i want my user's request to be processed and sent to /signup ??
  end

  get '/login' do
    #binding.pry
    erb :'users/login'
  end

   post '/login' do
    #binding.pry
  user = User.find_by(username: params[:Username])
  if user != nil && user.authenticate(params[:Password])
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

end
