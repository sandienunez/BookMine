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
        book = Book.create(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
        if book 
        # erb :'books/edit'
        #binding.pry
        redirect to "/books/#{book.id}"
    else
       redirect '/books/new' 
      end
    end 

     get '/books/:id' do 
        @book = Book.find_by_id(params[:id])
        if session[:user] == @book.user
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
        book = Book.find_by_id(params[:id])
        book.update(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
        redirect "/books/#{book.id}"
      end

      delete '/books/:id/delete' do
        book = Book.find_by_id(params[:id])
        book.destroy
        redirect '/books'

      end
end