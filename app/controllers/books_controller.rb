class BooksController < ApplicationController
    get '/books/new' do

        if logged_in?
            current_user
            erb :"/books/new"
          else
            redirect to "/"
          end
    end
      #CREATE --> NEW ACTION, renders new view


    get '/books' do 
        if logged_in?
          @books = current_user.books
            erb :"/books/index"
          else
            redirect to "/users"
          end       
    end

      #CREATE --->create action, handles form data, then redirects


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

        #READ: index action, renders an index view 


     get '/books/:id' do 
        @book = Book.find_by_id(params[:id])
        
        if session[:user_id] == @book.user_id
          #binding.pry 
         erb :'books/show'
        else 
        redirect '/books' #to routes 
        end 
    end 
  #READ: show action, renders a show view 


     get '/books/:id/edit' do
        @book = Book.find_by_id(params[:id])
        erb :'books/edit'
     end
    #UPDATE: edit action, renders edit view


     patch '/books/:id' do
        book = Book.find_by_id(params[:id])
        book.update(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
        #binding.pry
        redirect "/books/#{book.id}"
      end
            #UPDATE action, handles form data, then redirects 


      delete '/books/:id' do
        book = Book.find_by_id(params[:id])
        #binding.pry
        if session[:user_id] != book.user_id
          redirect '/books'
        else 
          book.destroy
        redirect '/books'
        end 
      end
          #DELETE: deletes action, deletes resource, then redirects --> triggered by button in the show and or index view

end