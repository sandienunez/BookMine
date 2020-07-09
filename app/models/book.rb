class Book < ActiveRecord::Base 
    belongs_to :user
    validates_presence_of :book_title #could add more

end