class BooksController < ApplicationController

  
#CREATE --->create action, handles form data, then redirects

      #CREATE --> NEW ACTION, renders new view

post '/books' do
   if logged_in?
      @user = current_user #making connection with book and user class, fetching user instance for current user 
      @book = Book.create(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
#@book = Book.create(book_title: params[:Book Title], author: params[:Author], book_genre: params[:Book Genre], number_of_pages: params[:Number of Pages], start: params[:start], end: params[:end], time_one: params[time_1], time_two: params[time_2], read: params[:read])
       @book.user = @user
       @book.save
    if @book.save
      redirect "/books/#{@book.id}"
    else
      redirect '/books/new'
    end 
  end 
end
        #READ: index action, renders an index view 

       get '/books/new' do
         if logged_in?
          erb :'books/new'
         else 
          redirect '/'
         end
       end

        get '/books' do #index route 
          if logged_in?
            @user = current_user
           erb :'books/index'
          else 
            redirect '/'
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
    #explain is this too dry?
    @book = Book.find_by_id(params[:id])
    #go over find by id 
    # :id = means dynamic, can change
    erb :'books/edit'
    if authorized_to_edit?(@book)
      erb :'books/edit'
    else
      flash[:error] = "You are not authorized to edit these books! You are not the user! :)"
      redirect '/books'
    end 
  else 
    redirect '/login'
  end 
end

    #UPDATE: edit action, renders edit view


     patch '/books/:id' do
        book = current_user.books.find_by_id(params[:id])
      #finding the book from the collection of the user's books instead of going through ALL the books
        book.update(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
        redirect "/books/#{book.id}"
      end
            #UPDATE action, handles form data, then redirects 


      delete '/books/:id/delete' do
        @book = Book.find_by_id(params[:id])
        #binding.pry
        if authorized_to_edit?(@book)
          @book.destroy 
          redirect '/books'
        else
          redirect '/home'
        end
      end
       
      
      #DELETE: deletes action, deletes resource, then redirects --> triggered by button in the show and or index view
    
    
  end 