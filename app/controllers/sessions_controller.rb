class SessionsController < ApplicationController

    get '/login' do
        erb :'users/login'
      end
    
    post '/login' do
      user = User.find_by(email: params[:email].strip)
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect '/books'
       else
        redirect '/login'
       end 
    end
    
      get '/logout' do 
      if logged_in?
        flash[:notice] = "Thanks for signing up!"
        session.clear
        redirect '/'
      end  
    end 

end