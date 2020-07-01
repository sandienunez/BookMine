class BooksController < ApplicationController
    get '/books/new' do
       "Here is your customized book list:"
    end

    get '/books' do 
        "Here are my books"
        
    end
end