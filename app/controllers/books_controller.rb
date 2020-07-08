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
        @books = Book.all 
        if logged_in?
          current_user
            erb :"/books/index"
          else
            redirect to "/users"
          end       
    end

    post '/books' do
        #binding.pry
        @book = Book.create(params)
        if @book 
        # erb :'books/edit'
        #binding.pry
        redirect to "/books/#{@book.id}"
    else
       redirect '/books/new' 
      end
    end 

     get '/books/:id' do 
        @book = Book.find_by_id(params[:id])
        if session[:user_id] == @book.user_id 
         erb :'books/show'
        else 
        redirect '/books' #to routes 
        end 
    end 

     get '/books/:id/edit' do
        @book = Book.find_by_id(params[:id])
        erb :'books/edit'
     end

     patch '/books/:id' do
        redirect '/books'
      end
end