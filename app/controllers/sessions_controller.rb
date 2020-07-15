class SessionsController < ApplicationController

    get '/login' do
        erb :'sessions/login'
      end
    
    post '/login' do
      user = User.find_by(email: params[:email].strip)
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        flash[:notice] = "Welcome Back!!"
        redirect '/books'
       else
        redirect '/login'
       end 
    end
    
      get '/logout' do 
      if logged_in?
        flash[:notice] = "You have successfully logged out! Have an amazing BookGenie Day!"
        session.clear
        redirect '/'
      end  
    end 

end