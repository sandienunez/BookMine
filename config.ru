require './config/environment'

require_relative 'app/controllers/books_controller'
require_relative 'app/controllers/users_controller'

#this allows us to use HTTP methods like puts/patch
require 'sinatra/base'
require 'rack-flash'
use Rack::MethodOverride



use UsersController
use SessionsController
use BooksController  #mounting controllers
# this requires any images and css that are stored in the /public directory
use Rack::Static, :root => 'public', :urls => ['/images', '/stylesheets']
# You might need to mount your controller(s) as middelware
run ApplicationController
# Mount the main controller as our Rack Application
