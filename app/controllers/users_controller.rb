class UsersController < ApplicationController
    use Rack::Flash
    get '/users/new' do
        "Welcome to your Users page"
     end
    
end