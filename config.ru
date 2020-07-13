require './config/environment'
#this allows us to use HTTP methods like puts/patch
require 'rack-flash'
use Rack::MethodOverride


use UsersController
use BooksController  #mounting controllers
# this requires any images and css that are stored in the /public directory
use Rack::Static, :root => 'public', :urls => ['/images', '/stylesheets']
# You might need to mount your controller(s) as middelware
run ApplicationController
# Mount the main controller as our Rack Application
