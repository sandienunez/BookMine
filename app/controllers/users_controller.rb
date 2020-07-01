class UsersController < ApplicationController
    get '/users/new' do
        "Welcome to your Users page"
     end

     get '/login' do
        erb :"users/login"
    end 

    post '/login' do 
       #binding.pry
       redirect '/books'
    
    end
end