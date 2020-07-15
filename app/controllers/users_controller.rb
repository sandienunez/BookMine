class UsersController < ApplicationController
    use Rack::Flash

    get '/signup' do
      if !session[:id] #if its false
      erb :'users/signup' 
      #I want my user to go to sign up page so redirect them to users/signup
      else
        redirect '/books/new'
      end 
    end
    
    post '/signup' do 
      # i want my user's request to be processed and sent to /signup 
       user = User.new(email: params[:email], password: params[:password])
      if user.save #how you validate if user gives all info 
      session[:user_id] = user.id 
      flash[:message] = "Thanks for signing up!"
          redirect '/books/new'
      end 
          redirect '/'
      end

end