class UsersController < ApplicationController

    get '/signup' do
      if !session[:id] #if its false
      erb :'users/signup' 
      #I want my user to go to sign up page so redirect them to users/signup
      end
    end 
    
    post '/signup' do 
      # i want my user's request to be processed and sent to /signup 
       user = User.new(email: params[:email], password: params[:password])
      if user.save #how you validate if user gives all info 
      session[:user_id] = user.id 
      #session is hash
      flash[:notice] = "Thanks for signing up #{user.email}!"
          redirect '/home' 
      else 
          redirect '/'   
      end
    end

end