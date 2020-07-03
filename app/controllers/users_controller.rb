class UsersController < ApplicationController
    use Rack::Flash
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

    post '/logout' do 
        redirect '/books'
    end
end