class BooksController < ApplicationController

#<---CREATE ---> get '/books/new' = called NEW ACTION, renders new view

  get '/books/new' do
      redirect_if_not_logged_in 
      erb :'books/new'
  end                              
#<---CREATE ---> post '/books' = called create action, handles form data, then redirects 

  post '/books' do
    redirect_if_not_logged_in
    @book = current_user.books.build(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])

      if @book.save
        redirect "/books/#{@book.id}"
      else
        redirect '/books/new'
      end 
  end

#<---READ ---> get '/books' do = called index action, renders an index view 

  get '/books' do #index route 
    if logged_in? 
      @user = current_user
      erb :'books/index'
    else 
      redirect '/'
    end 
  end

#<---READ --->  get '/books/:id' = called show action, renders a show view 

  get '/books/:id' do 
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if session[:user_id] == @book.user_id 
        erb :'books/show'
        else 
          redirect '/books' 
      end 
    else 
      redirect '/login'
    end 
  end  


#<---UPDATE --->  get '/books/:id/edit' = called edit action, renders edit view
  get '/books/:id/edit' do
    if logged_in?
      @user = current_user
      @book = Book.find_by_id(params[:id])
      erb :'books/edit'
      if authorized_to_edit?(@book)
        erb :'books/edit'
      else
        flash[:error] = "Hey! Genie says you're not authorized to edit this book! So VAMOOSE! Yeah you get outta here!"
        redirect '/books'
      end
    else
      redirect '/login'
    end
  end


#<---UPDATE ---> patch '/books/:id' do = called update action, handles form data submission, then redirects 

  patch '/books/:id' do
    if logged_in?
      book = Book.find_by_id(params[:id])
      book.update(book_title: params["Book Title"], author: params["Author"], book_genre: params["Book Genre"], number_of_pages: params["Number of Pages"], start: params["start"], end: params["end"], time_one: params["time_1"], time_two: params["time_2"], read: params["read"])
      redirect "/books/#{book.id}"
    else 
      flash[:error] = "Sorry! Genie says you don't have access to edit this book! Scram! Or else Genie will banish you to 28895345345345353529 years stuck in the genie lamp! "
      redirect "/"
    end 
  end

#<---DELETE ---> delete '/books/:id' do = called delete action, deletes resource, then redirects --> triggered by button in the show and or index view

  delete '/books/:id' do
      redirect_if_not_logged_in
      book = Book.find_by_id(params[:id])
      if authorized_to_edit?(book)
        book.destroy 
        redirect '/books'
      else
        redirect '/home'
      end
  end    
    
end 