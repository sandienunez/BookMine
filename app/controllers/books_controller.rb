class BooksController < ApplicationController
    get '/books/new' do
       "Here is your customized book list:"
    end

    get '/books' do 
        "Here you can create your own customized book list:"

    end
end