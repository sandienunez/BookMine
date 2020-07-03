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

  get '/login' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/books'
    end

    get '/login' do
      
    end
  end

end
