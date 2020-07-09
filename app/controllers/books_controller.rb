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
        @book = Book.create(book_title: params[:book_title], author: params[:author], book_genre: params[:book_genre], number_of_pages: params[:number_of_pages], start: params[:start], end: params[:end], time_one: params[:time_one], time_two: params[:time_two], read: params[:read])
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
        @book = Book.find_by_id(params[:id])
        book.update(book_title: params[:book_title], author: params[:author], book_genre: params[:book_genre], number_of_pages: params[:number_of_pages], start: params[:start], end: params[:end], time_one: params[:time_one], time_two: params[:time_two], read: params[:read])
        redirect "/books/#{@book.id}"
      end

      delete '/books/:id/delete' do
        @book = Book.find_by_id(params[:id])
        book.destroy
        redirect "/books"

      end
end