class SessionsController < ApplicationController

    get '/login' do
        erb :'sessions/login'
        #render my login form
      end
    
    post '/login' do
        #receive data (params) from the login form
      user = User.find_by(email: params[:email].strip)
      #find the user
      if user && user.authenticate(params[:password])
        #authenticate the user
        session[:user_id] = user.id 
        #create key/value pair in session using users id to actually log them in
        flash[:notice] = "Welcome back #{user.email} !"
        #add success message to flash hash
        redirect '/books'
       else
        flash[:error] = "Invalid email or password. Please try again!"
        #show error message
        #this is where my error message will display (at the login route)
        redirect '/login'
        #redirecting back to login page
       end 
    end
    
      get '/logout' do 
      if logged_in?
        session.clear
        flash[:notice] = "You have successfully logged out! Have an amazing BookGenie Day!"
        redirect '/'
      end  
    end 

end