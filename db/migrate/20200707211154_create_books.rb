class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :book_title
      t.string :author
      t.string :book_genre
      t.integer :number_of_pages
      t.date :start
      t.date :end 
      t.time :time_one
      t.time :time_two
      t.boolean :read
      t.string :user_id
    end 
      
    
  end
end
