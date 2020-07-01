require './config/environment'
#this allows us to use HTTP methods like puts/patch
require 'rack-flash'



# require 'sinatra'
# require 'sinatra/base'
# require 'sinatra/flash'
#     enable :sessions
#     register Sinatra::Flash
# if ActiveRecord::Migrator.needs_migration?
#   # raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

use UsersController
use BooksController  #mounting controllers
use Rack::MethodOverride
# this requires any images and css that are stored in the /public directory
use Rack::Static, :root => 'public', :urls => ['/images', '/stylesheets']
# You might need to mount your controller(s) as middelware
run ApplicationController
# Mount the main controller as our Rack Application
