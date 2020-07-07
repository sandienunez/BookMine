class BooksController < ApplicationController
    get '/books/new' do

        if logged_in?
            current_user
            erb :"/books/new"
          else
            redirect to "/"
          end
    end

    get '/books' do 
        if logged_in?
          current_user
            erb :"/books/edit"
          else
            redirect to "/users"
          end       
    end

    post '/books' do
        # erb :'books/edit'
        binding.pry
        # redirect to "/books/#{book.id}"
      end

     get '/books/:id' do 
         erb :'books/show'
     end 
end