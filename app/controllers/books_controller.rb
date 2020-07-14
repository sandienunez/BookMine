class BooksController < ApplicationController
  use Rack::Flash

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
          #binding.pry
            erb :"/books/index"
          else
            redirect to "/users"
          end       
    end

      #CREATE --->create action, handles form data, then redirects


    post '/books' do
        #binding.pry
        if logged_in?
          @user = current_user #making connection with book and user class, fetching user instance for current user 
          @book = Book.create(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
            if @book 
              @user.books << @book 
              redirect "/books/#{@book.id}"
            else
              redirect '/books/new'
            end 
        end 
    end 

        #READ: index action, renders an index view 

        get '/view' do 
          if logged_in?
            @user = current_user
           erb :'books/view'
          end 
        end

        get '/edit' do 
          if logged_in?
            @user = current_user
             @books = @user.books 
             erb :'books/edit'
          end 
        end

        get '/delete' do 
          if logged_in?
            @user = current_user
            erb :'books/delete'
          end 
        end 

        get '/books/:id/delete' do 
          if logged_in?
            @user = current_user
           # binding.pry
          @book = Book.find_by_id(params[:id])
          erb :'books/remove'
        end
      end 
    
     get '/books/:id' do 
      if logged_in?
        @book = Book.find_by_id(params[:id])
        if session[:user_id] == @book.user_id
          erb :'books/show'
        else 
          redirect '/books' #to routes 
        end 
      else 
        redirect '/login'
    end 
  end  
  #READ: show action, renders a show view 


     get '/books/:id/edit' do
        if logged_in?
          @user = current_user
          @book = Book.find_by_id(params[:id])
          erb :'books/update'
        end
      end

    #UPDATE: edit action, renders edit view


     patch '/books/:id' do
        book = Book.find_by_id(params[:id])
        book.update(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
        redirect "/books/#{book.id}"
      end
            #UPDATE action, handles form data, then redirects 


      delete '/books/:id' do
        book = Book.find_by_id(params[:id])
          if session[:user_id] != book.user_id
            redirect '/books'
          else 
            book.destroy
            redirect '/books'
          end 
      end
          #DELETE: deletes action, deletes resource, then redirects --> triggered by button in the show and or index view
end 