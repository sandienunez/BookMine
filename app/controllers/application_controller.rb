require './config/environment'

class ApplicationController < Sinatra::Base
 #we are inheriting from sinatra base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #enables sessions hash
    enable :sessions
    #set a session secret for extra security layer
    register Sinatra::Flash
    #registers sinatra flash gem/functionality 
    set :session_secret, "f650ed69344bab0084199bb8cc9aa5a1bd6756c3b57ad67023255af0fc3795057e"
  end

  get "/" do
    erb :welcome
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
