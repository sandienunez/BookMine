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
    set :session_secret, ENV.fetch("SECRET") 
  end

  get '/' do
    erb :welcome
  end

  get '/home' do 
    if logged_in?
      @books = current_user.books
        erb :"home"
      else
        flash[:notice] = "Welcome!"
        redirect to "/"
      end       
  end

  helpers do
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
      #returns boolean if user is logged in or not 
    end

    def authorized_to_edit?(book)
      book.user_id == current_user.id
    end

    def redirect_if_not_logged_in
      redirect '/login' if !logged_in?
    end
  end
  
end 
